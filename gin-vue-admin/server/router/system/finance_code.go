package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type CodeRouter struct{}

// InitCodeRouter 初始化 兑换码明细 路由信息
func (s *CodeRouter) InitCodeRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	codeRouter := Router.Group("code").Use(middleware.OperationRecord())
	codeRouterWithoutRecord := Router.Group("code")
	codeRouterWithoutAuth := PublicRouter.Group("code")
	{
		codeRouter.POST("createCode", codeApi.CreateCode)             // 新建兑换码明细
		codeRouter.DELETE("deleteCode", codeApi.DeleteCode)           // 删除兑换码明细
		codeRouter.DELETE("deleteCodeByIds", codeApi.DeleteCodeByIds) // 批量删除兑换码明细
		codeRouter.PUT("updateCode", codeApi.UpdateCode)              // 更新兑换码明细
	}
	{
		codeRouterWithoutRecord.GET("findCode", codeApi.FindCode)       // 根据ID获取兑换码明细
		codeRouterWithoutRecord.GET("getCodeList", codeApi.GetCodeList) // 获取兑换码明细列表
	}
	{
		codeRouterWithoutAuth.GET("getCodePublic", codeApi.GetCodePublic) // 兑换码明细开放接口
	}
}
