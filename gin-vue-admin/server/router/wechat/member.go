package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type WechatMemberRouter struct{}

// InitWechatMemberRouter 初始化微信会员路由
func (s *WechatMemberRouter) InitWechatMemberRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 需要认证的路由
	memberRouter := Router.Group("api/wx/member").
		Use(middleware.JWTAuth()) // 使用系统JWT认证中间件
	{
		memberRouter.POST("open", wechatMemberApi.OpenMember) // 开通会员
	}

	// 公开路由（微信支付回调）
	memberPublicRouter := PublicRouter.Group("api/wx/member")
	{
		memberPublicRouter.POST("callback/:orderNo", wechatMemberApi.MemberPaymentCallback) // 支付回调
	}
}
