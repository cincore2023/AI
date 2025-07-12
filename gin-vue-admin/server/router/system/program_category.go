package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type CategoryRouter struct{}

// InitCategoryRouter 初始化 分类 路由信息
func (s *CategoryRouter) InitCategoryRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	categoryRouter := Router.Group("category").Use(middleware.OperationRecord())
	categoryRouterWithoutRecord := Router.Group("category")
	categoryRouterWithoutAuth := PublicRouter.Group("category")
	{
		categoryRouter.POST("createCategory", categoryApi.CreateCategory)             // 新建分类
		categoryRouter.DELETE("deleteCategory", categoryApi.DeleteCategory)           // 删除分类
		categoryRouter.DELETE("deleteCategoryByIds", categoryApi.DeleteCategoryByIds) // 批量删除分类
		categoryRouter.PUT("updateCategory", categoryApi.UpdateCategory)              // 更新分类
	}
	{
		categoryRouterWithoutRecord.GET("findCategory", categoryApi.FindCategory)       // 根据ID获取分类
		categoryRouterWithoutRecord.GET("getCategoryList", categoryApi.GetCategoryList) // 获取分类列表
	}
	{
		categoryRouterWithoutAuth.GET("getCategoryPublic", categoryApi.GetCategoryPublic) // 分类开放接口
	}
}
