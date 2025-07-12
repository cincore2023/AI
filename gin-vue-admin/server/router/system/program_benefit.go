package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type BenefitRouter struct{}

// InitBenefitRouter 初始化 权益等级 路由信息
func (s *BenefitRouter) InitBenefitRouter(Router *gin.RouterGroup, PublicRouter *gin.RouterGroup) {
	benefitRouter := Router.Group("benefit").Use(middleware.OperationRecord())
	benefitRouterWithoutRecord := Router.Group("benefit")
	benefitRouterWithoutAuth := PublicRouter.Group("benefit")
	{
		benefitRouter.POST("createBenefit", benefitApi.CreateBenefit)             // 新建权益等级
		benefitRouter.DELETE("deleteBenefit", benefitApi.DeleteBenefit)           // 删除权益等级
		benefitRouter.DELETE("deleteBenefitByIds", benefitApi.DeleteBenefitByIds) // 批量删除权益等级
		benefitRouter.PUT("updateBenefit", benefitApi.UpdateBenefit)              // 更新权益等级
	}
	{
		benefitRouterWithoutRecord.GET("findBenefit", benefitApi.FindBenefit)       // 根据ID获取权益等级
		benefitRouterWithoutRecord.GET("getBenefitList", benefitApi.GetBenefitList) // 获取权益等级列表
	}
	{
		benefitRouterWithoutAuth.GET("getBenefitPublic", benefitApi.GetBenefitPublic) // 权益等级开放接口
	}
}
