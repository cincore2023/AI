package wechat

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type WechatUserInfoApi struct{}

// WxDecryptPhoneRequest 微信手机号解密请求参数
type WxDecryptPhoneRequest struct {
	Code string `json:"code" binding:"required"` // 微信手机号获取凭证
}

// WxUpdateUserInfoRequest 更新用户信息请求参数
type WxUpdateUserInfoRequest struct {
	Nickname string `json:"nickname,omitempty"` // 用户昵称
	Avatar   string `json:"avatar,omitempty"`   // 用户头像URL
}

// WxDecryptPhoneResponse 微信手机号解密响应
type WxDecryptPhoneResponse struct {
	PhoneNumber string `json:"phoneNumber"` // 解密后的手机号
}

// WxPhoneInfoResponse 微信获取手机号接口响应
type WxPhoneInfoResponse struct {
	ErrCode   int    `json:"errcode"`
	ErrMsg    string `json:"errmsg"`
	PhoneInfo struct {
		PhoneNumber     string `json:"phoneNumber"`
		PurePhoneNumber string `json:"purePhoneNumber"`
		CountryCode     string `json:"countryCode"`
		Watermark       struct {
			Timestamp int64  `json:"timestamp"`
			Appid     string `json:"appid"`
		} `json:"watermark"`
	} `json:"phone_info"`
}

// WxWechatUserWithSalesperson 包含销售员信息的微信用户信息
type WxWechatUserWithSalesperson struct {
	system.WechatUser
	SalespersonInfo *WxSalespersonInfo `json:"salespersonInfo,omitempty"` // 销售员信息
}

// WxDecryptPhone 微信手机号解密
// @Tags     WechatUserInfoApi
// @Summary  微信手机号解密
// @Description 通过微信获取的加密手机号code直接获取真实手机号，需要登录鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxDecryptPhoneRequest                                    true  "微信手机号获取凭证"
// @Success  200   {object}  response.Response{data=WxDecryptPhoneResponse,msg=string}  "解密成功"
// @Failure  400   {object}  response.Response{msg=string}                           "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                           "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                           "服务器内部错误"
// @Router   /api/wx/DecryptPhone [post]
func (w *WechatUserInfoApi) WxDecryptPhone(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxDecryptPhoneRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("微信手机号解密请求",
		zap.Uint("userID", userID),
		zap.String("code", req.Code))

	// 获取微信配置
	appID := global.GVA_CONFIG.System.WxAppID
	appSecret := global.GVA_CONFIG.System.WxAppSecret
	if appID == "" || appSecret == "" {
		global.GVA_LOG.Error("微信小程序配置不完整")
		response.FailWithMessage("微信小程序配置不完整", c)
		return
	}

	// 通过code获取access_token
	accessToken, err := w.getAccessToken(appID, appSecret)
	if err != nil {
		global.GVA_LOG.Error("获取access_token失败!", zap.Error(err))
		response.FailWithMessage("获取access_token失败: "+err.Error(), c)
		return
	}

	// 调用微信接口获取手机号
	phoneInfo, err := w.getPhoneNumberByCode(accessToken, req.Code)
	if err != nil {
		global.GVA_LOG.Error("获取手机号失败!", zap.Error(err))
		response.FailWithMessage("获取手机号失败: "+err.Error(), c)
		return
	}

	phoneNumber := phoneInfo.PhoneInfo.PhoneNumber

	// 更新用户手机号
	err = wxUserService.UpdateUserPhoneNumber(c.Request.Context(), userID, phoneNumber)
	if err != nil {
		global.GVA_LOG.Error("更新用户手机号失败!", zap.Error(err))
		response.FailWithMessage("更新用户手机号失败: "+err.Error(), c)
		return
	}

	// 返回解密后的手机号
	decryptResponse := WxDecryptPhoneResponse{
		PhoneNumber: phoneNumber,
	}

	global.GVA_LOG.Info("微信手机号获取成功",
		zap.Uint("userID", userID),
		zap.String("phoneNumber", phoneNumber))
	response.OkWithDetailed(decryptResponse, "手机号获取成功", c)
}

// getAccessToken 获取微信access_token
func (w *WechatUserInfoApi) getAccessToken(appID, appSecret string) (string, error) {
	// 请求微信API获取access_token
	url := fmt.Sprintf("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",
		appID, appSecret)

	resp, err := http.Get(url)
	if err != nil {
		return "", fmt.Errorf("请求微信API失败: %v", err)
	}
	defer resp.Body.Close()

	var tokenResp struct {
		AccessToken string `json:"access_token"`
		ExpiresIn   int    `json:"expires_in"`
		ErrCode     int    `json:"errcode"`
		ErrMsg      string `json:"errmsg"`
	}
	err = json.NewDecoder(resp.Body).Decode(&tokenResp)
	if err != nil {
		return "", fmt.Errorf("解析微信API响应失败: %v", err)
	}

	if tokenResp.ErrCode != 0 {
		return "", fmt.Errorf("微信API错误: %s", tokenResp.ErrMsg)
	}

	if tokenResp.AccessToken == "" {
		return "", fmt.Errorf("获取access_token失败")
	}

	return tokenResp.AccessToken, nil
}

// getPhoneNumberByCode 通过code获取手机号
func (w *WechatUserInfoApi) getPhoneNumberByCode(accessToken, code string) (*WxPhoneInfoResponse, error) {
	// 构造请求URL
	apiURL := fmt.Sprintf("https://api.weixin.qq.com/wxa/business/getuserphonenumber?access_token=%s", accessToken)

	// 构造请求数据
	requestData := map[string]string{
		"code": code,
	}

	// 将请求数据转换为JSON
	jsonData, err := json.Marshal(requestData)
	if err != nil {
		return nil, fmt.Errorf("构造请求数据失败: %v", err)
	}

	// 发送POST请求
	resp, err := http.Post(apiURL, "application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		return nil, fmt.Errorf("请求微信API失败: %v", err)
	}
	defer resp.Body.Close()

	// 解析响应
	var phoneResp WxPhoneInfoResponse
	err = json.NewDecoder(resp.Body).Decode(&phoneResp)
	if err != nil {
		return nil, fmt.Errorf("解析微信API响应失败: %v", err)
	}

	if phoneResp.ErrCode != 0 {
		return nil, fmt.Errorf("微信API错误: %s", phoneResp.ErrMsg)
	}

	return &phoneResp, nil
}

// WxUpdateUserInfo 更新微信用户信息
// @Tags     WechatUserInfoApi
// @Summary  更新微信用户信息
// @Description 更新微信用户的昵称和头像，需要登录鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxUpdateUserInfoRequest                          true  "用户信息"
// @Success  200   {object}  response.Response{msg=string}                   "更新成功"
// @Failure  400   {object}  response.Response{msg=string}                   "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                   "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                   "服务器内部错误"
// @Router   /api/wx/UpdateUserInfo [post]
func (w *WechatUserInfoApi) WxUpdateUserInfo(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxUpdateUserInfoRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("更新微信用户信息请求",
		zap.Uint("userID", userID),
		zap.String("nickname", req.Nickname),
		zap.String("avatar", req.Avatar))

	// 构建更新数据
	updateData := make(map[string]interface{})
	if req.Nickname != "" {
		updateData["nickname"] = req.Nickname
	}
	if req.Avatar != "" {
		updateData["avatar"] = req.Avatar
	}

	// 更新用户信息
	err = wxUserService.UpdateUserInfo(c.Request.Context(), userID, updateData)
	if err != nil {
		global.GVA_LOG.Error("更新用户信息失败!", zap.Error(err))
		response.FailWithMessage("更新用户信息失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("更新微信用户信息成功",
		zap.Uint("userID", userID))
	response.OkWithMessage("用户信息更新成功", c)
}

// WxUploadAvatar 上传用户头像
// @Tags     WechatUserInfoApi
// @Summary  上传用户头像
// @Description 上传微信用户头像，需要登录鉴权
// @Accept   multipart/form-data
// @Produce  application/json
// @Param    file  formData  file                    true  "头像文件"
// @Success  200   {object}  response.Response{data=string,msg=string}  "上传成功"
// @Failure  400   {object}  response.Response{msg=string}             "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}             "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}             "服务器内部错误"
// @Router   /api/wx/UploadAvatar [post]
func (w *WechatUserInfoApi) WxUploadAvatar(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	global.GVA_LOG.Info("上传用户头像请求",
		zap.Uint("userID", userID))

	// 获取上传的文件
	file, err := c.FormFile("file")
	if err != nil {
		global.GVA_LOG.Error("获取上传文件失败!", zap.Error(err))
		response.FailWithMessage("获取上传文件失败: "+err.Error(), c)
		return
	}

	// 保存文件到服务器
	// 这里应该调用文件上传服务
	// 模拟文件保存路径
	filePath := fmt.Sprintf("/uploads/avatar/%d_%s", userID, file.Filename)

	// TODO: 实际的文件保存逻辑
	// 这里应该调用文件服务来保存文件并返回访问URL

	// 模拟文件访问URL
	fileURL := global.GVA_CONFIG.Local.Path + filePath

	// 更新用户头像URL
	err = wxUserService.UpdateUserAvatar(c.Request.Context(), userID, fileURL)
	if err != nil {
		global.GVA_LOG.Error("更新用户头像失败!", zap.Error(err))
		response.FailWithMessage("更新用户头像失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("上传用户头像成功",
		zap.Uint("userID", userID),
		zap.String("fileURL", fileURL))
	response.OkWithDetailed(fileURL, "头像上传成功", c)
}

// GetWechatUserInfo 获取微信用户信息
// @Tags     WechatUserInfoApi
// @Summary  获取微信用户信息
// @Description 获取当前登录微信用户的详细信息，需要登录鉴权
// @Accept   application/json
// @Produce  application/json
// @Success  200   {object}  response.Response{data=WxWechatUserWithSalesperson,msg=string}  "获取成功"
// @Failure  401   {object}  response.Response{msg=string}                        "未登录或登录已过期"
// @Failure  500   {object}  response.Response{msg=string}                        "服务器内部错误"
// @Router   /api/wx/GetUserInfo [get]
func (w *WechatUserInfoApi) GetWechatUserInfo(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	global.GVA_LOG.Info("获取微信用户信息请求",
		zap.Uint("userID", userID))

	// 获取用户信息
	user, err := wxUserService.GetWechatUser(c.Request.Context(), fmt.Sprintf("%d", userID))
	if err != nil {
		global.GVA_LOG.Error("获取用户信息失败!", zap.Error(err))
		response.FailWithMessage("获取用户信息失败: "+err.Error(), c)
		return
	}

	// 创建包含销售员信息的响应结构
	userWithSalesperson := WxWechatUserWithSalesperson{
		WechatUser: user,
	}

	// 如果用户有销售员，则获取销售员信息
	if user.Salesperson != nil && *user.Salesperson > 0 {
		salesperson, err := wxUserService.GetWechatUser(c.Request.Context(), fmt.Sprintf("%d", *user.Salesperson))
		if err == nil && salesperson.Nickname != nil && salesperson.PhoneNumber != nil {
			salespersonInfo := &WxSalespersonInfo{
				ID:          salesperson.ID,
				Nickname:    *salesperson.Nickname,
				PhoneNumber: *salesperson.PhoneNumber,
			}
			userWithSalesperson.SalespersonInfo = salespersonInfo
		}
	}

	global.GVA_LOG.Info("获取微信用户信息成功",
		zap.Uint("userID", userID))
	response.OkWithDetailed(userWithSalesperson, "获取用户信息成功", c)
}
