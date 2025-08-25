package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatActivityRouter struct{}

func (s *WechatActivityRouter) InitWechatActivityRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信活动API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatActivityPublicRouter := PublicRouter.Group("api/wx")
	{
		wechatActivityPublicRouter.GET("Activities", wechatActivityApi.WxGetActivities)         // 微信小程序活动列表
		wechatActivityPublicRouter.GET("Activities/:id", wechatActivityApi.WxGetActivityDetail) // 微信小程序活动详情
	}
}
