package wechat

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type WechatUserInfoRouter struct{}

// InitWechatUserInfoRouter 初始化微信用户信息路由
func (s *WechatUserInfoRouter) InitWechatUserInfoRouter(Router *gin.RouterGroup) {
	// 微信用户信息API需要认证
	wechatUserInfoRouter := Router.Group("api/wx").Use(middleware.JWTAuth())
	{
		wechatUserInfoRouter.POST("/DecryptPhone", wechatUserInfoApi.WxDecryptPhone)     // 微信手机号解密
		wechatUserInfoRouter.POST("/UpdateUserInfo", wechatUserInfoApi.WxUpdateUserInfo) // 更新用户信息
		wechatUserInfoRouter.POST("/UploadAvatar", wechatUserInfoApi.WxUploadAvatar)     // 上传用户头像
	}
}
