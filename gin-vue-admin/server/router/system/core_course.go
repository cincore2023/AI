package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type CourseRouter struct{}

// InitCourseRouter 初始化 课程管理 路由信息
func (s *CourseRouter) InitCourseRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	courseRouter := Router.Group("course").Use(middleware.OperationRecord())
	courseRouterWithoutRecord := Router.Group("course")
	courseRouterWithoutAuth := PublicRouter.Group("course")
	{
		courseRouter.POST("createCourse", courseApi.CreateCourse)             // 新建课程管理
		courseRouter.DELETE("deleteCourse", courseApi.DeleteCourse)           // 删除课程管理
		courseRouter.DELETE("deleteCourseByIds", courseApi.DeleteCourseByIds) // 批量删除课程管理
		courseRouter.PUT("updateCourse", courseApi.UpdateCourse)              // 更新课程管理
	}
	{
		courseRouterWithoutRecord.GET("findCourse", courseApi.FindCourse)       // 根据ID获取课程管理
		courseRouterWithoutRecord.GET("getCourseList", courseApi.GetCourseList) // 获取课程管理列表
	}
	{
		courseRouterWithoutAuth.GET("getCourseDataSource", courseApi.GetCourseDataSource) // 获取课程管理数据源
		courseRouterWithoutAuth.GET("getCoursePublic", courseApi.GetCoursePublic)         // 课程管理开放接口
	}
}
