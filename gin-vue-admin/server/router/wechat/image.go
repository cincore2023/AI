package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatImageRouter struct{}

// InitWechatImageRouter 初始化微信图片上传路由
func (s *WechatImageRouter) InitWechatImageRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信图片上传API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatImagePublicRouter := PublicRouter.Group("api/wx")
	{
		wechatImagePublicRouter.POST("uploadImage", wechatImageApi.WxUploadImage) // 微信小程序上传图片
	}
}
