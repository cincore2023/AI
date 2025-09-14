package utils

import (
	"bytes"
	"crypto/md5"
	"crypto/tls"
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"math/rand"
	"net/http"
	"sort"
	"strings"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"go.uber.org/zap"
)

// WechatPayConfig 微信支付配置
type WechatPayConfig struct {
	AppID     string // 微信小程序AppID
	MchID     string // 商户号
	APIKey    string // API密钥
	NotifyURL string // 支付回调地址
}

// UnifiedOrderRequest 统一下单请求参数
type UnifiedOrderRequest struct {
	XMLName        xml.Name `xml:"xml"`
	AppID          string   `xml:"appid"`            // 应用ID
	MchID          string   `xml:"mch_id"`           // 商户号
	NonceStr       string   `xml:"nonce_str"`        // 随机字符串
	Sign           string   `xml:"sign"`             // 签名
	Body           string   `xml:"body"`             // 商品描述
	OutTradeNo     string   `xml:"out_trade_no"`     // 商户订单号
	TotalFee       int      `xml:"total_fee"`        // 总金额(分)
	SpbillCreateIP string   `xml:"spbill_create_ip"` // 终端IP
	NotifyURL      string   `xml:"notify_url"`       // 通知地址
	TradeType      string   `xml:"trade_type"`       // 交易类型
}

// UnifiedOrderResponse 统一下单响应
type UnifiedOrderResponse struct {
	ReturnCode string `xml:"return_code"` // 返回状态码
	ReturnMsg  string `xml:"return_msg"`  // 返回信息
	AppID      string `xml:"appid"`       // 应用ID
	MchID      string `xml:"mch_id"`      // 商户号
	NonceStr   string `xml:"nonce_str"`   // 随机字符串
	Sign       string `xml:"sign"`        // 签名
	ResultCode string `xml:"result_code"` // 业务结果
	PrepayID   string `xml:"prepay_id"`   // 预支付交易会话标识
	TradeType  string `xml:"trade_type"`  // 交易类型
}

// WechatPayRequest 微信支付请求参数(前端需要的参数)
type WechatPayRequest struct {
	AppID     string `json:"appId"`     // 应用ID
	TimeStamp string `json:"timeStamp"` // 时间戳
	NonceStr  string `json:"nonceStr"`  // 随机字符串
	Package   string `json:"package"`   // 订单详情扩展字符串
	SignType  string `json:"signType"`  // 签名方式
	PaySign   string `json:"paySign"`   // 签名
}

// CreateUnifiedOrder 调用微信统一下单接口
func CreateUnifiedOrder(config WechatPayConfig, body, outTradeNo string, totalFee int, spbillCreateIP, tradeType string) (*UnifiedOrderResponse, error) {
	// 构造请求参数
	req := UnifiedOrderRequest{
		AppID:          config.AppID,
		MchID:          config.MchID,
		NonceStr:       generateNonceStr(32),
		Body:           body,
		OutTradeNo:     outTradeNo,
		TotalFee:       totalFee,
		SpbillCreateIP: spbillCreateIP,
		NotifyURL:      config.NotifyURL,
		TradeType:      tradeType,
	}

	// 生成签名
	sign := generateUnifiedOrderSign(req, config.APIKey)
	req.Sign = sign

	// 转换为XML
	xmlData, err := xml.MarshalIndent(req, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("构造XML请求失败: %v", err)
	}

	// 记录请求参数用于调试
	global.GVA_LOG.Info("微信统一下单请求参数",
		zap.String("request_xml", string(xmlData)))

	// 发送请求到微信支付统一下单接口
	url := "https://api.mch.weixin.qq.com/pay/unifiedorder"
	httpClient := &http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
		},
		Timeout: 10 * time.Second,
	}

	resp, err := httpClient.Post(url, "application/xml", bytes.NewBuffer(xmlData))
	if err != nil {
		return nil, fmt.Errorf("请求微信统一下单接口失败: %v", err)
	}
	defer resp.Body.Close()

	// 读取响应
	bodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("读取响应失败: %v", err)
	}

	// 记录响应内容用于调试
	global.GVA_LOG.Info("微信统一下单响应", zap.String("response_xml", string(bodyBytes)))

	// 解析XML响应
	var unifiedOrderResp UnifiedOrderResponse
	err = xml.Unmarshal(bodyBytes, &unifiedOrderResp)
	if err != nil {
		return nil, fmt.Errorf("解析XML响应失败: %v", err)
	}

	// 检查返回状态码
	if unifiedOrderResp.ReturnCode != "SUCCESS" {
		return nil, fmt.Errorf("微信统一下单失败: %s", unifiedOrderResp.ReturnMsg)
	}

	// 检查业务结果
	if unifiedOrderResp.ResultCode != "SUCCESS" {
		return nil, fmt.Errorf("微信统一下单业务失败: %s", unifiedOrderResp.ReturnMsg)
	}

	return &unifiedOrderResp, nil
}

// GenerateWechatPayParams 生成微信支付参数(前端需要的参数)
func GenerateWechatPayParams(config WechatPayConfig, prepayID string) *WechatPayRequest {
	// 生成时间戳
	timeStamp := fmt.Sprintf("%d", time.Now().Unix())

	// 生成随机字符串
	nonceStr := generateNonceStr(32)

	// 生成签名
	signParams := map[string]string{
		"appId":     config.AppID,
		"timeStamp": timeStamp,
		"nonceStr":  nonceStr,
		"package":   "prepay_id=" + prepayID,
		"signType":  "MD5",
	}

	paySign := generatePaySign(signParams, config.APIKey)

	// 记录支付参数用于调试
	global.GVA_LOG.Info("微信支付参数",
		zap.String("appId", config.AppID),
		zap.String("timeStamp", timeStamp),
		zap.String("nonceStr", nonceStr),
		zap.String("package", "prepay_id="+prepayID),
		zap.String("signType", "MD5"),
		zap.String("paySign", paySign))

	// 构造返回参数
	payParams := &WechatPayRequest{
		AppID:     config.AppID,
		TimeStamp: timeStamp,
		NonceStr:  nonceStr,
		Package:   "prepay_id=" + prepayID,
		SignType:  "MD5",
		PaySign:   paySign,
	}

	return payParams
}

// generateNonceStr 生成指定长度的随机字符串
func generateNonceStr(length int) string {
	chars := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var sb strings.Builder
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < length; i++ {
		sb.WriteByte(chars[rand.Intn(len(chars))])
	}
	return sb.String()
}

// generateUnifiedOrderSign 生成统一下单签名
func generateUnifiedOrderSign(req UnifiedOrderRequest, apiKey string) string {
	// 构造签名字符串
	params := map[string]string{
		"appid":            req.AppID,
		"mch_id":           req.MchID,
		"nonce_str":        req.NonceStr,
		"body":             req.Body,
		"out_trade_no":     req.OutTradeNo,
		"total_fee":        fmt.Sprintf("%d", req.TotalFee),
		"spbill_create_ip": req.SpbillCreateIP,
		"notify_url":       req.NotifyURL,
		"trade_type":       req.TradeType,
	}

	return generateSign(params, apiKey)
}

// generatePaySign 生成支付签名(前端需要的签名)
func generatePaySign(params map[string]string, apiKey string) string {
	return generateSign(params, apiKey)
}

// generateSign 生成签名
func generateSign(params map[string]string, apiKey string) string {
	// 过滤空值参数
	filteredParams := make(map[string]string)
	for k, v := range params {
		if v != "" {
			filteredParams[k] = v
		}
	}

	// 按照key的ASCII码从小到大排序（字典序）
	var keys []string
	for k := range filteredParams {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	// 拼接字符串
	var sb strings.Builder
	for _, k := range keys {
		if filteredParams[k] != "" {
			sb.WriteString(k)
			sb.WriteString("=")
			sb.WriteString(filteredParams[k])
			sb.WriteString("&")
		}
	}

	// 拼接API密钥
	sb.WriteString("key=")
	sb.WriteString(apiKey)

	// MD5签名
	signStr := sb.String()
	h := md5.New()
	h.Write([]byte(signStr))
	sign := fmt.Sprintf("%X", h.Sum(nil))

	// 记录签名过程用于调试
	global.GVA_LOG.Debug("签名过程",
		zap.Strings("sorted_keys", keys),
		zap.String("sign_string", signStr),
		zap.String("sign", sign))

	return sign
}
