package wechat

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type WechatApi struct{}

// WxLoginRequest 微信登录请求参数
type WxLoginRequest struct {
	Code string `json:"code" binding:"required"` // 微信登录code
}

// WxLoginResponse 微信登录响应
type WxLoginResponse struct {
	IsNewUser bool              `json:"isNewUser"` // 是否为新用户
	User      system.WechatUser `json:"user"`      // 微信用户信息
	Token     string            `json:"token"`     // 访问令牌
	ExpiresAt int64             `json:"expiresAt"` // 过期时间
}

// WxSessionResponse 微信会话响应
type WxSessionResponse struct {
	OpenID     string `json:"openid"`      // 用户openid
	SessionKey string `json:"session_key"` // 会话密钥
	UnionID    string `json:"unionid"`     // 用户unionid
	ErrCode    int    `json:"errcode"`     // 错误码
	ErrMsg     string `json:"errmsg"`      // 错误信息
}

// WxLogin 微信小程序登录
// @Tags     WechatApi
// @Summary  微信小程序登录
// @Description 微信小程序用户登录接口，通过微信code获取用户信息并生成JWT token
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxLoginRequest                                          true  "微信登录code"
// @Success  200   {object}  response.Response{data=WxLoginResponse,msg=string}     "返回包括用户信息,是否新用户"
// @Failure  400   {object}  response.Response{msg=string}                          "请求参数错误"
// @Failure  500   {object}  response.Response{msg=string}                          "服务器内部错误"
// @Router   /api/wxLogin [post]
func (w *WechatApi) WxLogin(c *gin.Context) {
	var req WxLoginRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("微信登录请求", zap.String("code", req.Code))

	// 1. 通过code获取openid
	openID, err := w.getOpenIDFromCode(req.Code)
	if err != nil {
		global.GVA_LOG.Error("获取openid失败!", zap.Error(err))
		response.FailWithMessage("微信登录失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("成功获取openid", zap.String("openId", openID))

	// 2. 根据openid查找或创建微信用户
	wxUser, isNewUser, err := w.findOrCreateWechatUser(openID)
	if err != nil {
		global.GVA_LOG.Error("创建微信用户失败!", zap.Error(err))
		response.FailWithMessage("用户创建失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("微信用户处理完成", zap.Uint("userId", wxUser.ID), zap.Bool("isNewUser", isNewUser))

	// 3. 生成专用于微信用户的token
	token, expiresAt, err := w.generateWechatUserToken(wxUser)
	if err != nil {
		global.GVA_LOG.Error("生成token失败!", zap.Error(err))
		response.FailWithMessage("生成token失败: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("token生成成功", zap.String("token", token[:20]+"..."), zap.Int64("expiresAt", expiresAt))

	// 4. 返回结果
	wxLoginResponse := WxLoginResponse{
		IsNewUser: isNewUser,
		User:      *wxUser,
		Token:     token,
		ExpiresAt: expiresAt,
	}

	global.GVA_LOG.Info("微信登录成功", zap.Uint("userId", wxUser.ID))
	response.OkWithDetailed(wxLoginResponse, "微信登录成功", c)
}

// getOpenIDFromCode 通过code获取openid
func (w *WechatApi) getOpenIDFromCode(code string) (string, error) {
	// 微信小程序配置，这里应该从配置文件读取
	appID := global.GVA_CONFIG.System.WxAppID         // 需要在配置中添加
	appSecret := global.GVA_CONFIG.System.WxAppSecret // 需要在配置中添加

	if appID == "" || appSecret == "" {
		return "", fmt.Errorf("微信小程序配置不完整")
	}

	// 请求微信API
	url := fmt.Sprintf("https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code",
		appID, appSecret, code)

	resp, err := http.Get(url)
	if err != nil {
		return "", fmt.Errorf("请求微信API失败: %v", err)
	}
	defer resp.Body.Close()

	var wxResp WxSessionResponse
	err = json.NewDecoder(resp.Body).Decode(&wxResp)
	if err != nil {
		return "", fmt.Errorf("解析微信API响应失败: %v", err)
	}

	if wxResp.ErrCode != 0 {
		return "", fmt.Errorf("微信API错误: %s", wxResp.ErrMsg)
	}

	if wxResp.OpenID == "" {
		return "", fmt.Errorf("获取openid失败")
	}

	return wxResp.OpenID, nil
}

// findOrCreateWechatUser 查找或创建微信用户
func (w *WechatApi) findOrCreateWechatUser(openID string) (*system.WechatUser, bool, error) {
	var wxUser system.WechatUser
	err := global.GVA_DB.Where("open_id = ?", openID).First(&wxUser).Error

	if err == nil {
		// 用户已存在
		return &wxUser, false, nil
	}

	// 用户不存在，创建新用户
	nickname := "微信用户" + openID[len(openID)-8:] // 使用openid后8位作为默认昵称
	isActive := true
	benefitLevel := 1 // 默认权益等级
	withdrawableIncome := 0.0
	cumulativeIncome := 0.0

	wxUser = system.WechatUser{
		OpenId:             &openID,
		Nickname:           &nickname,
		IsActive:           &isActive,
		BenefitLevel:       &benefitLevel,
		WithdrawableIncome: &withdrawableIncome,
		CumulativeIncome:   &cumulativeIncome,
		// 其他字段使用默认值（nil）
	}

	err = global.GVA_DB.Create(&wxUser).Error
	if err != nil {
		return nil, false, fmt.Errorf("创建微信用户失败: %v", err)
	}

	return &wxUser, true, nil
}

// generateWechatUserToken 为微信用户生成专用token
func (w *WechatApi) generateWechatUserToken(wxUser *system.WechatUser) (string, int64, error) {
	// 使用系统的JWT工具生成token
	j := utils.NewJWT()

	// 创建微信用户的claims
	baseClaims := systemReq.BaseClaims{
		UUID:        uuid.New(), // 生成新的UUID
		ID:          wxUser.ID,
		Username:    *wxUser.Nickname,
		NickName:    *wxUser.Nickname,
		AuthorityId: 1, // 微信用户默认权限
	}

	claims := j.CreateClaims(baseClaims)
	token, err := j.CreateToken(claims)
	if err != nil {
		return "", 0, err
	}

	expiresAt := claims.RegisteredClaims.ExpiresAt.Unix() * 1000
	return token, expiresAt, nil
}

// WxBindSalespersonRequest 绑定销售员请求参数
type WxBindSalespersonRequest struct {
	SalespersonPhone string `json:"salespersonPhone" binding:"required"` // 销售员手机号
}

// WxBindSalespersonResponse 绑定销售员响应
type WxBindSalespersonResponse struct {
	Salesperson    WxSalespersonInfo `json:"salesperson"`    // 销售员信息
	BindingSuccess bool              `json:"bindingSuccess"` // 绑定是否成功
	Message        string            `json:"message"`        // 绑定结果消息
}

// WxSalespersonInfo 销售员信息
type WxSalespersonInfo struct {
	ID          uint   `json:"id"`          // 销售员ID
	Nickname    string `json:"nickname"`    // 销售员昵称
	PhoneNumber string `json:"phoneNumber"` // 销售员手机号
}

// WxBindSalesperson 绑定销售员
// @Tags     WechatApi
// @Summary  绑定销售员
// @Description 通过手机号查找并绑定销售员，需要登录鉴权
// @Accept   application/json
// @Produce  application/json
// @Param    data  body      WxBindSalespersonRequest                                           true  "销售员手机号"
// @Success  200   {object}  response.Response{data=WxBindSalespersonResponse,msg=string}     "绑定成功"
// @Failure  400   {object}  response.Response{msg=string}                                     "请求参数错误"
// @Failure  401   {object}  response.Response{msg=string}                                     "未登录或登录已过期"
// @Failure  404   {object}  response.Response{msg=string}                                     "没有该销售员"
// @Failure  500   {object}  response.Response{msg=string}                                     "服务器内部错误"
// @Router   /api/wx/BindSalesperson [post]
func (w *WechatApi) WxBindSalesperson(c *gin.Context) {
	// 获取当前用户ID
	userID := utils.GetUserID(c)

	var req WxBindSalespersonRequest
	err := c.ShouldBindJSON(&req)
	if err != nil {
		global.GVA_LOG.Error("参数绑定失败!", zap.Error(err))
		response.FailWithMessage("请求参数错误: "+err.Error(), c)
		return
	}

	global.GVA_LOG.Info("绑定销售员请求",
		zap.Uint("userID", userID),
		zap.String("salespersonPhone", req.SalespersonPhone))

	// 首先查找销售员信息
	salesperson, err := wxUserService.GetSalespersonByPhone(c.Request.Context(), req.SalespersonPhone)
	if err != nil {
		global.GVA_LOG.Error("查找销售员失败!", zap.Error(err))
		// 返回不成功的响应，但包含销售员信息为空
		bindResponse := WxBindSalespersonResponse{
			Salesperson:    WxSalespersonInfo{},
			BindingSuccess: false,
			Message:        err.Error(),
		}
		response.OkWithDetailed(bindResponse, "查找销售员失败", c)
		return
	}

	// 绑定销售员
	err = wxUserService.BindSalesperson(c.Request.Context(), userID, req.SalespersonPhone)
	if err != nil {
		global.GVA_LOG.Error("绑定销售员失败!", zap.Error(err))
		// 返回不成功的响应，但包含销售员信息
		salespersonInfo := WxSalespersonInfo{
			ID: salesperson.ID,
			Nickname: func() string {
				if salesperson.Nickname != nil {
					return *salesperson.Nickname
				}
				return ""
			}(),
			PhoneNumber: func() string {
				if salesperson.PhoneNumber != nil {
					return *salesperson.PhoneNumber
				}
				return ""
			}(),
		}
		bindResponse := WxBindSalespersonResponse{
			Salesperson:    salespersonInfo,
			BindingSuccess: false,
			Message:        "绑定失败: " + err.Error(),
		}
		response.OkWithDetailed(bindResponse, "绑定销售员失败", c)
		return
	}

	// 绑定成功，返回销售员信息
	salespersonInfo := WxSalespersonInfo{
		ID: salesperson.ID,
		Nickname: func() string {
			if salesperson.Nickname != nil {
				return *salesperson.Nickname
			}
			return ""
		}(),
		PhoneNumber: func() string {
			if salesperson.PhoneNumber != nil {
				return *salesperson.PhoneNumber
			}
			return ""
		}(),
	}

	bindResponse := WxBindSalespersonResponse{
		Salesperson:    salespersonInfo,
		BindingSuccess: true,
		Message:        "绑定成功",
	}

	global.GVA_LOG.Info("绑定销售员成功",
		zap.Uint("userID", userID),
		zap.Uint("salespersonID", salesperson.ID))
	response.OkWithDetailed(bindResponse, "绑定成功", c)
}
