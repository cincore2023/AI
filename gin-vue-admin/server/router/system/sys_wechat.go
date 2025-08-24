package system

import (
	"github.com/gin-gonic/gin"
)

type WechatRouter struct{}

// InitWechatRouter 初始化微信小程序API路由
func (s *WechatRouter) InitWechatRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信API不需要认证，放在PublicRouter中
	wechatPublicRouter := PublicRouter.Group("api")
	{
		wechatPublicRouter.POST("wxLogin", wechatApi.WxLogin) // 微信小程序登录
	}
}
