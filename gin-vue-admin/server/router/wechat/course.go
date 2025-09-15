package wechat

import (
	"github.com/gin-gonic/gin"
)

type WechatCourseRouter struct{}

func (s *WechatCourseRouter) InitWechatCourseRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	// 微信课程API不需要认证，放在PublicRouter中，使用api/wx前缀
	wechatCoursePublicRouter := PublicRouter.Group("api/wx")
	{
		wechatCoursePublicRouter.GET("Courses", wechatCourseApi.WxGetCourses)          // 微信小程序课程列表
		wechatCoursePublicRouter.GET("Courses/:id", wechatCourseApi.WxGetCourseDetail) // 微信小程序课程详情
		wechatCoursePublicRouter.GET("Categories", wechatCourseApi.WxGetCategories)    // 微信小程序分类列表
	}

	// 需要认证的微信课程API，放在Router中
	wechatCourseRouter := Router.Group("api/wx")
	{
		wechatCourseRouter.POST("Courses/favorite", wechatCourseApi.WxToggleCourseFavorite) // 收藏/取消收藏课程
		wechatCourseRouter.GET("Courses/:id/favorite", wechatCourseApi.WxIsCourseFavorite)  // 检查课程是否已收藏
		wechatCourseRouter.GET("Courses/favorite", wechatCourseApi.WxGetFavoriteCourses)    // 获取用户收藏课程列表
	}
}
