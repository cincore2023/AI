package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatRouter struct{}

// InitWechatRouter 初始化微信小程序API路由
func (s *WechatRouter) InitWechatRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信公开API，不需要认证
	wechatPublicRouter := PublicRouter.Group("api/wx")
	{
		wechatPublicRouter.POST("Login", wechatApi.WxLogin) // 微信小程序登录
	}

	// 需要认证
	wechatAuthRouter := Router.Group("api/wx")
	{
		wechatAuthRouter.POST("BindSalesperson", wechatApi.WxBindSalesperson) // 绑定销售员
	}
}
