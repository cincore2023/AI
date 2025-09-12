package wechat

import "github.com/flipped-aurora/gin-vue-admin/server/service"

// ApiGroup 微信模块API分组
type ApiGroup struct {
	WechatApi
	WechatBannerApi
	WechatTeacherApi
	WechatCourseApi
	WechatActivityApi
	WechatImageApi
	WechatUserInfoApi
	WechatMemberApi
}

var ApiGroupApp = new(ApiGroup)

var (
	wechatApi         = ApiGroupApp.WechatApi
	wechatBannerApi   = ApiGroupApp.WechatBannerApi
	wechatTeacherApi  = ApiGroupApp.WechatTeacherApi
	wechatCourseApi   = ApiGroupApp.WechatCourseApi
	wechatActivityApi = ApiGroupApp.WechatActivityApi
	wechatImageApi    = ApiGroupApp.WechatImageApi
	wechatUserInfoApi = ApiGroupApp.WechatUserInfoApi
	wechatMemberApi   = ApiGroupApp.WechatMemberApi

	bannerService         = service.ServiceGroupApp.SystemServiceGroup.BannerService
	teacherService        = service.ServiceGroupApp.SystemServiceGroup.TeacherService
	courseService         = service.ServiceGroupApp.SystemServiceGroup.CourseService
	courseFavoriteService = service.ServiceGroupApp.SystemServiceGroup.CourseFavoriteService
	categoryService       = service.ServiceGroupApp.SystemServiceGroup.CategoryService
	activitiesService     = service.ServiceGroupApp.SystemServiceGroup.ActivitiesService
	wxUserService         = service.ServiceGroupApp.SystemServiceGroup.WechatUserService
)
