package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type PosterRouter struct{}

// InitPosterRouter 初始化 推广海报 路由信息
func (s *PosterRouter) InitPosterRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	posterRouter := Router.Group("poster").Use(middleware.OperationRecord())
	posterRouterWithoutRecord := Router.Group("poster")
	posterRouterWithoutAuth := PublicRouter.Group("poster")
	{
		posterRouter.POST("createPoster", posterApi.CreatePoster)             // 新建推广海报
		posterRouter.DELETE("deletePoster", posterApi.DeletePoster)           // 删除推广海报
		posterRouter.DELETE("deletePosterByIds", posterApi.DeletePosterByIds) // 批量删除推广海报
		posterRouter.PUT("updatePoster", posterApi.UpdatePoster)              // 更新推广海报
	}
	{
		posterRouterWithoutRecord.GET("findPoster", posterApi.FindPoster)       // 根据ID获取推广海报
		posterRouterWithoutRecord.GET("getPosterList", posterApi.GetPosterList) // 获取推广海报列表
	}
	{
		posterRouterWithoutAuth.GET("getPosterPublic", posterApi.GetPosterPublic) // 推广海报开放接口
	}
}
