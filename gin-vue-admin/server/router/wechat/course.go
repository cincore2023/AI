package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatCourseRouter struct{}

func (s *WechatCourseRouter) InitWechatCourseRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	wechatCoursePublicRouter := PublicRouter.Group("api")
	{
		wechatCoursePublicRouter.GET("wxCourses", wechatCourseApi.WxGetCourses) // 微信小程序课程列表
	}
}
