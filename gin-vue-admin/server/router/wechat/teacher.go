package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatTeacherRouter struct{}

func (s *WechatTeacherRouter) InitWechatTeacherRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信教师API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatTeacherPublicRouter := PublicRouter.Group("api/wx")
	{
		wechatTeacherPublicRouter.GET("Teachers", wechatTeacherApi.WxGetTeachers)          // 微信小程序讲师列表
		wechatTeacherPublicRouter.GET("Teachers/:id", wechatTeacherApi.WxGetTeacherDetail) // 微信小程序讲师详情
	}
}
