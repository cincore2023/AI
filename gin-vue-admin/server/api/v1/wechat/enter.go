package wechat

import "github.com/flipped-aurora/gin-vue-admin/server/service"

// ApiGroup 微信模块API分组
type ApiGroup struct {
	WechatApi
	WechatBannerApi
	WechatTeacherApi
	
}

var ApiGroupApp = new(ApiGroup)

var (
	bannerService  = service.ServiceGroupApp.SystemServiceGroup.BannerService
	teacherService = service.ServiceGroupApp.SystemServiceGroup.TeacherService
	courseService  = service.ServiceGroupApp.SystemServiceGroup.CourseService
)
