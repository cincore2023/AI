package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type WechatUserRouter struct{}

// InitWechatUserRouter 初始化 用户管理 路由信息
func (s *WechatUserRouter) InitWechatUserRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	wxUserRouter := Router.Group("wxUser").Use(middleware.OperationRecord())
	wxUserRouterWithoutRecord := Router.Group("wxUser")
	wxUserRouterWithoutAuth := PublicRouter.Group("wxUser")
	{
		wxUserRouter.POST("createWechatUser", wxUserApi.CreateWechatUser)             // 新建用户管理
		wxUserRouter.DELETE("deleteWechatUser", wxUserApi.DeleteWechatUser)           // 删除用户管理
		wxUserRouter.DELETE("deleteWechatUserByIds", wxUserApi.DeleteWechatUserByIds) // 批量删除用户管理
		wxUserRouter.PUT("updateWechatUser", wxUserApi.UpdateWechatUser)              // 更新用户管理
	}
	{
		wxUserRouterWithoutRecord.GET("findWechatUser", wxUserApi.FindWechatUser)       // 根据ID获取用户管理
		wxUserRouterWithoutRecord.GET("getWechatUserList", wxUserApi.GetWechatUserList) // 获取用户管理列表
	}
	{
		wxUserRouterWithoutAuth.GET("getWechatUserPublic", wxUserApi.GetWechatUserPublic) // 用户管理开放接口
	}
}
