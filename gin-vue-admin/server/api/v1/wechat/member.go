package wechat

import (
	"net"
	"strings"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatMemberApi struct{}

// OpenMemberRequest 开通会员请求参数
type OpenMemberRequest struct {
	// 无需参数，会员档位和金额由后端固定
}

// OpenMemberResponse 开通会员响应
type OpenMemberResponse struct {
	AppID     string  `json:"appId"`     // 应用ID
	TimeStamp string  `json:"timeStamp"` // 时间戳
	NonceStr  string  `json:"nonceStr"`  // 随机字符串
	Package   string  `json:"package"`   // 订单包
	SignType  string  `json:"signType"`  // 签名类型
	PaySign   string  `json:"paySign"`   // 支付签名
	Amount    float64 `json:"amount"`    // 支付金额
	OrderNo   string  `json:"orderNo"`   // 订单编号
}

// OpenMember 开通会员
// @Tags     WechatMemberApi
// @Summary  开通会员
// @Description 用户开通会员接口，创建订单并返回支付信息
// @Accept   application/json
// @Produce  application/json
// @Success  200   {object}  response.Response{data=OpenMemberResponse,msg=string}  "返回订单信息用于支付"
// @Failure  400   {object}  response.Response{msg=string}                         "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                         "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                         "服务器内部错误"
// @Router   /api/wx/member/open [post]
func (w *WechatMemberApi) OpenMember(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)
	if userID == 0 {
		global.GVA_LOG.Error("获取用户信息失败")
		response.FailWithMessage("获取用户信息失败", c)
		return
	}

	// 获取用户详细信息
	var wxUser system.WechatUser
	err := global.GVA_DB.Where("id = ?", userID).First(&wxUser).Error
	if err != nil {
		global.GVA_LOG.Error("获取用户信息失败!", zap.Error(err))
		response.FailWithMessage("获取用户信息失败: "+err.Error(), c)
		return
	}

	// 创建订单
	orderNo := utils.GenerateOrderNumber() // 生成订单号
	amount := 199.0                        // 固定会员费用199元，可根据需求调整

	// 创建订单记录（简化实现，实际应包含更多订单信息）
	order := system.Order{
		OrderNo:       orderNo,
		UserID:        userID,
		Amount:        amount,
		ActualAmount:  amount,
		Status:        "pending", // 待支付
		PaymentMethod: "wechat",  // 微信支付
	}

	err = global.GVA_DB.Create(&order).Error
	if err != nil {
		global.GVA_LOG.Error("创建订单失败!", zap.Error(err))
		response.FailWithMessage("创建订单失败: "+err.Error(), c)
		return
	}

	// 获取客户端IP
	clientIP := getClientIP(c)

	// 配置微信支付参数
	wxPayConfig := utils.WechatPayConfig{
		AppID:     global.GVA_CONFIG.System.WxAppID,                       // 微信小程序AppID
		MchID:     global.GVA_CONFIG.System.WxMchID,                       // 微信支付商户号
		APIKey:    global.GVA_CONFIG.System.WxAPIKey,                      // 微信支付API密钥
		NotifyURL: getServerURL(c) + "/api/wx/member/callback/" + orderNo, // 支付回调地址
	}

	// 调用微信统一下单接口
	totalFee := int(amount * 100) // 转换为分
	unifiedOrderResp, err := utils.CreateUnifiedOrder(
		wxPayConfig,
		"会员年卡", // 商品描述
		orderNo,    // 商户订单号
		totalFee,   // 总金额(分)
		clientIP,   // 终端IP
		"JSAPI",    // 交易类型
	)
	if err != nil {
		global.GVA_LOG.Error("调用微信统一下单接口失败!", zap.Error(err))
		response.FailWithMessage("调用微信支付失败: "+err.Error(), c)
		return
	}

	// 生成前端支付参数
	payParams := utils.GenerateWechatPayParams(wxPayConfig, unifiedOrderResp.PrepayID)

	responseData := OpenMemberResponse{
		AppID:     payParams.AppID,
		TimeStamp: payParams.TimeStamp,
		NonceStr:  payParams.NonceStr,
		Package:   payParams.Package,
		SignType:  payParams.SignType,
		PaySign:   payParams.PaySign,
		Amount:    amount,
		OrderNo:   orderNo,
	}

	global.GVA_LOG.Info("会员开通订单创建成功", zap.Uint("userID", userID), zap.String("orderNo", orderNo), zap.Float64("amount", amount))
	response.OkWithDetailed(responseData, "订单创建成功，请调用支付接口完成支付", c)
}

// getClientIP 获取客户端IP地址
func getClientIP(c *gin.Context) string {
	// 首先尝试从X-Forwarded-For头部获取
	ip := c.GetHeader("X-Forwarded-For")
	if ip != "" {
		// 取第一个IP地址
		if ips := strings.Split(ip, ","); len(ips) > 0 {
			ip = strings.TrimSpace(ips[0])
			if net.ParseIP(ip) != nil {
				return ip
			}
		}
	}

	// 尝试从X-Real-IP头部获取
	ip = c.GetHeader("X-Real-IP")
	if ip != "" && net.ParseIP(ip) != nil {
		return ip
	}

	// 从gin上下文获取
	if ip, _, err := net.SplitHostPort(c.Request.RemoteAddr); err == nil {
		return ip
	}

	// 默认返回
	return "127.0.0.1"
}

// getServerURL 获取服务器URL
func getServerURL(c *gin.Context) string {
	// 获取协议
	scheme := "http"
	if c.Request.TLS != nil {
		scheme = "https"
	}

	// 获取主机
	host := c.Request.Host
	if host == "" {
		host = "localhost:8888" // 默认端口
	}

	return scheme + "://" + host
}

// MemberPaymentCallback 会员支付回调
// @Tags     WechatMemberApi
// @Summary  会员支付回调
// @Description 支付成功后的回调处理，更新用户会员状态
// @Accept   application/json
// @Produce  application/json
// @Param    orderNo  path      string  true  "订单编号"
// @Success  200   {object}  response.Response{msg=string}  "支付处理成功"
// @Failure  400   {object}  response.Response{msg=string}  "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}  "服务器内部错误"
// @Router   /api/wx/member/callback/{orderNo} [post]
func (w *WechatMemberApi) MemberPaymentCallback(c *gin.Context) {
	orderNo := c.Param("orderNo")
	if orderNo == "" {
		global.GVA_LOG.Error("订单编号不能为空")
		response.FailWithMessage("订单编号不能为空", c)
		return
	}

	// 查找订单
	var order system.Order
	err := global.GVA_DB.Where("order_no = ?", orderNo).First(&order).Error
	if err != nil {
		global.GVA_LOG.Error("订单不存在!", zap.String("orderNo", orderNo), zap.Error(err))
		response.FailWithMessage("订单不存在: "+err.Error(), c)
		return
	}

	// 检查订单状态
	if order.Status == "paid" {
		global.GVA_LOG.Info("订单已处理", zap.String("orderNo", orderNo))
		response.OkWithMessage("订单已处理", c)
		return
	}

	// 更新订单状态为已支付
	now := time.Now().Unix()
	updateData := map[string]interface{}{
		"status":       "paid",
		"payment_time": &now,
	}

	err = global.GVA_DB.Model(&system.Order{}).Where("order_no = ?", orderNo).Updates(updateData).Error
	if err != nil {
		global.GVA_LOG.Error("更新订单状态失败!", zap.String("orderNo", orderNo), zap.Error(err))
		response.FailWithMessage("更新订单状态失败: "+err.Error(), c)
		return
	}

	// 更新用户会员过期时间（默认开通一年）
	// 如果用户已经有会员，则在现有到期时间基础上延长一年
	// 如果用户没有会员，则从现在开始计算一年
	var wxUser system.WechatUser
	err = global.GVA_DB.Where("id = ?", order.UserID).First(&wxUser).Error
	if err != nil {
		global.GVA_LOG.Error("获取用户信息失败!", zap.Uint("userID", order.UserID), zap.Error(err))
		response.FailWithMessage("获取用户信息失败: "+err.Error(), c)
		return
	}

	// 计算新的会员到期时间
	var newExpiryDate time.Time
	if wxUser.MembershipExpiryDate != nil && wxUser.MembershipExpiryDate.After(time.Now()) {
		// 如果当前会员还未过期，则在现有到期时间基础上延长一年
		newExpiryDate = wxUser.MembershipExpiryDate.AddDate(1, 0, 0)
	} else {
		// 如果当前没有会员或会员已过期，则从现在开始计算一年
		newExpiryDate = time.Now().AddDate(1, 0, 0)
	}

	updateUserData := map[string]interface{}{
		"membership_expiry_date": &newExpiryDate,
		"updated_by":             order.UserID,
	}

	err = global.GVA_DB.Model(&system.WechatUser{}).Where("id = ?", order.UserID).Updates(updateUserData).Error
	if err != nil {
		global.GVA_LOG.Error("更新用户会员状态失败!", zap.Uint("userID", order.UserID), zap.Error(err))
		response.FailWithMessage("更新用户会员状态失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("会员开通成功", zap.Uint("userID", order.UserID), zap.String("orderNo", orderNo))
	response.OkWithMessage("会员开通成功", c)
}
