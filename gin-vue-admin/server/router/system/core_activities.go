package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type ActivitiesRouter struct{}

// InitActivitiesRouter 初始化 活动管理 路由信息
func (s *ActivitiesRouter) InitActivitiesRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	activitiesRouter := Router.Group("activities").Use(middleware.OperationRecord())
	activitiesRouterWithoutRecord := Router.Group("activities")
	activitiesRouterWithoutAuth := PublicRouter.Group("activities")
	{
		activitiesRouter.POST("createActivities", activitiesApi.CreateActivities)             // 新建活动管理
		activitiesRouter.DELETE("deleteActivities", activitiesApi.DeleteActivities)           // 删除活动管理
		activitiesRouter.DELETE("deleteActivitiesByIds", activitiesApi.DeleteActivitiesByIds) // 批量删除活动管理
		activitiesRouter.PUT("updateActivities", activitiesApi.UpdateActivities)              // 更新活动管理
	}
	{
		activitiesRouterWithoutRecord.GET("findActivities", activitiesApi.FindActivities)       // 根据ID获取活动管理
		activitiesRouterWithoutRecord.GET("getActivitiesList", activitiesApi.GetActivitiesList) // 获取活动管理列表
	}
	{
		activitiesRouterWithoutAuth.GET("getActivitiesDataSource", activitiesApi.GetActivitiesDataSource) // 获取活动管理数据源
		activitiesRouterWithoutAuth.GET("getActivitiesPublic", activitiesApi.GetActivitiesPublic)         // 活动管理开放接口
	}
}
