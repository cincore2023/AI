package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatBannerRouter struct{}

// InitWechatBannerRouter 初始化微信小程序轮播图API路由
func (s *WechatBannerRouter) InitWechatBannerRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信轮播图API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatBannerPublicRouter := PublicRouter.Group("api/wx")
	{
		wechatBannerPublicRouter.GET("Banners", wechatBannerApi.WxGetBanners) // 微信小程序轮播图
	}
}
