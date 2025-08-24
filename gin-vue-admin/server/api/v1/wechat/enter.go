package wechat

import "github.com/flipped-aurora/gin-vue-admin/server/service"

// ApiGroup 微信模块API分组
type ApiGroup struct {
	WechatApi
	WechatBannerApi
}

// ApiGroupApp 微信模块API实例
var ApiGroupApp = new(ApiGroup)

// 微信模块使用的服务实例
var (
	bannerService = service.ServiceGroupApp.SystemServiceGroup.BannerService
)