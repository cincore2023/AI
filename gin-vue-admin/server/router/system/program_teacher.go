package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type TeacherRouter struct{}

// InitTeacherRouter 初始化 讲师管理 路由信息
func (s *TeacherRouter) InitTeacherRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	teacherRouter := Router.Group("teacher").Use(middleware.OperationRecord())
	teacherRouterWithoutRecord := Router.Group("teacher")
	teacherRouterWithoutAuth := PublicRouter.Group("teacher")
	{
		teacherRouter.POST("createTeacher", teacherApi.CreateTeacher)             // 新建讲师管理
		teacherRouter.DELETE("deleteTeacher", teacherApi.DeleteTeacher)           // 删除讲师管理
		teacherRouter.DELETE("deleteTeacherByIds", teacherApi.DeleteTeacherByIds) // 批量删除讲师管理
		teacherRouter.PUT("updateTeacher", teacherApi.UpdateTeacher)              // 更新讲师管理
	}
	{
		teacherRouterWithoutRecord.GET("findTeacher", teacherApi.FindTeacher)       // 根据ID获取讲师管理
		teacherRouterWithoutRecord.GET("getTeacherList", teacherApi.GetTeacherList) // 获取讲师管理列表
	}
	{
		teacherRouterWithoutAuth.GET("getTeacherPublic", teacherApi.GetTeacherPublic) // 讲师管理开放接口
	}
}
