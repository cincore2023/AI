package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type BannerRouter struct{}

// InitBannerRouter 初始化 轮播管理 路由信息
func (s *BannerRouter) InitBannerRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	bannerRouter := Router.Group("banner").Use(middleware.OperationRecord())
	bannerRouterWithoutRecord := Router.Group("banner")
	bannerRouterWithoutAuth := PublicRouter.Group("banner")
	{
		bannerRouter.POST("createBanner", bannerApi.CreateBanner)             // 新建轮播管理
		bannerRouter.DELETE("deleteBanner", bannerApi.DeleteBanner)           // 删除轮播管理
		bannerRouter.DELETE("deleteBannerByIds", bannerApi.DeleteBannerByIds) // 批量删除轮播管理
		bannerRouter.PUT("updateBanner", bannerApi.UpdateBanner)              // 更新轮播管理
	}
	{
		bannerRouterWithoutRecord.GET("findBanner", bannerApi.FindBanner)       // 根据ID获取轮播管理
		bannerRouterWithoutRecord.GET("getBannerList", bannerApi.GetBannerList) // 获取轮播管理列表
	}
	{
		bannerRouterWithoutAuth.GET("getBannerPublic", bannerApi.GetBannerPublic) // 轮播管理开放接口
	}
}
