package wechat

import api "github.com/flipped-aurora/gin-vue-admin/server/api/v1/wechat"

// RouterGroup 微信模块路由分组
type RouterGroup struct {
	WechatRouter
	WechatBannerRouter
	WechatTeacherRouter
	WechatCourseRouter
	WechatActivityRouter
	WechatImageRouter
	WechatUserInfoRouter
	WechatMemberRouter
}

var (
	wechatApi         = api.ApiGroupApp.WechatApi
	wechatBannerApi   = api.ApiGroupApp.WechatBannerApi
	wechatTeacherApi  = api.ApiGroupApp.WechatTeacherApi
	wechatCourseApi   = api.ApiGroupApp.WechatCourseApi
	wechatActivityApi = api.ApiGroupApp.WechatActivityApi
	wechatImageApi    = api.ApiGroupApp.WechatImageApi
	wechatUserInfoApi = api.ApiGroupApp.WechatUserInfoApi
	wechatMemberApi   = api.ApiGroupApp.WechatMemberApi

	wechatMemberRouter = &WechatMemberRouter{}
)
