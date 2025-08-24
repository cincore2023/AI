package wechat

import api "github.com/flipped-aurora/gin-vue-admin/server/api/v1/wechat"

// RouterGroup 微信模块路由分组
type RouterGroup struct {
	WechatRouter
	WechatBannerRouter
}

var (
	wechatApi       = api.ApiGroupApp.WechatApi
	wechatBannerApi = api.ApiGroupApp.WechatBannerApi
)