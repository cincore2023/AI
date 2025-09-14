package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type WechatActivityRouter struct{}

func (s *WechatActivityRouter) InitWechatActivityRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信活动API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatActivityPublicRouter := PublicRouter.Group("api/wx")
	{
		wechatActivityPublicRouter.GET("Activities", wechatActivityApi.WxGetActivities)                                      // 微信小程序活动列表
		wechatActivityPublicRouter.GET("Activities/:id", wechatActivityApi.WxGetActivityDetail)                              // 微信小程序活动详情
		wechatActivityPublicRouter.POST("Activities/payment-callback/:orderNo", wechatActivityApi.WxActivityPaymentCallback) // 活动支付回调
	}

	// 需要认证的活动API路由
	wechatActivityRouter := Router.Group("api/wx").Use(middleware.JWTAuth())
	{
		wechatActivityRouter.POST("Activities/register", wechatActivityApi.WxRegisterForActivity)                     // 用户报名活动
		wechatActivityRouter.POST("Activities/create-order", wechatActivityApi.WxCreateActivityOrder)                 // 创建活动支付订单
		wechatActivityRouter.GET("Activities/registration-status", wechatActivityApi.WxGetActivityRegistrationStatus) // 获取活动报名状态
		wechatActivityRouter.POST("Activities/participant-info", wechatActivityApi.WxUpdateParticipantInfo)           // 更新参与者信息
		wechatActivityRouter.POST("Activities/partner-redemption", wechatActivityApi.WxPartnerRedemptionCode)         // 合伙人兑换码报名
	}
}
