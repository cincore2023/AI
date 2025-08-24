package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatTeacherRouter struct{}

func (s *WechatTeacherRouter) InitWechatTeacherRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	wechatTeacherPublicRouter := PublicRouter.Group("api")
	{
		wechatTeacherPublicRouter.GET("wxTeachers", wechatTeacherApi.WxGetTeachers)           // 微信小程序讲师列表
		wechatTeacherPublicRouter.GET("wxTeachers/:id", wechatTeacherApi.WxGetTeacherDetail) // 微信小程序讲师详情
	}
}
