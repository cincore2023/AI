package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatMemberRouter struct{}

// InitWechatMemberRouter 初始化微信会员路由
func (s *WechatMemberRouter) InitWechatMemberRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	memberRouter := Router.Group("api/wx")
	{
		memberRouter.POST("open", wechatMemberApi.OpenMember)                         // 开通会员
		memberRouter.POST("callback/:orderNo", wechatMemberApi.MemberPaymentCallback) // 支付回调
	}
}
