package initialize

import (
	"github.com/flipped-aurora/gin-vue-admin/server/router"
	"github.com/gin-gonic/gin"
)

func holder(routers ...*gin.RouterGroup) {
	_ = routers
	_ = router.RouterGroupApp
}
func initBizRouter(routers ...*gin.RouterGroup) {
	privateGroup := routers[0]
	publicGroup := routers[1]
	holder(publicGroup, privateGroup)
	{
		systemRouter := router.RouterGroupApp.System
		systemRouter.InitCategoryRouter(privateGroup, publicGroup)
		systemRouter.InitPosterRouter(privateGroup, publicGroup)
		systemRouter.InitBannerRouter(privateGroup, publicGroup)
		systemRouter.InitTeacherRouter(privateGroup, publicGroup)
		systemRouter.InitBenefitRouter(privateGroup, publicGroup)
		systemRouter.InitCourseRouter(privateGroup, publicGroup)
		systemRouter.InitWechatUserRouter(privateGroup, publicGroup)
		systemRouter.InitCodeRouter(privateGroup, publicGroup)                            // 占位方法，保证文件可以正确加载，避免go空变量检测报错，请勿删除。
		systemRouter.InitActivitiesRouter(privateGroup, publicGroup)
		
		// 微信模块路由（独立模块）
		wechatRouter := router.RouterGroupApp.Wechat
		wechatRouter.InitWechatRouter(privateGroup, publicGroup)        // 微信登录
		wechatRouter.InitWechatBannerRouter(privateGroup, publicGroup)  // 微信轮播图
		wechatRouter.InitWechatTeacherRouter(privateGroup, publicGroup) // 微信讲师
	}
}
