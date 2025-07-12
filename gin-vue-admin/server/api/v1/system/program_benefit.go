package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type BenefitApi struct{}

// CreateBenefit 创建权益等级
// @Tags Benefit
// @Summary 创建权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Benefit true "创建权益等级"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /benefit/createBenefit [post]
func (benefitApi *BenefitApi) CreateBenefit(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var benefit system.Benefit
	err := c.ShouldBindJSON(&benefit)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	benefit.CreatedBy = utils.GetUserID(c)
	err = benefitService.CreateBenefit(ctx, &benefit)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteBenefit 删除权益等级
// @Tags Benefit
// @Summary 删除权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Benefit true "删除权益等级"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /benefit/deleteBenefit [delete]
func (benefitApi *BenefitApi) DeleteBenefit(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := benefitService.DeleteBenefit(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteBenefitByIds 批量删除权益等级
// @Tags Benefit
// @Summary 批量删除权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /benefit/deleteBenefitByIds [delete]
func (benefitApi *BenefitApi) DeleteBenefitByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := benefitService.DeleteBenefitByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateBenefit 更新权益等级
// @Tags Benefit
// @Summary 更新权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Benefit true "更新权益等级"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /benefit/updateBenefit [put]
func (benefitApi *BenefitApi) UpdateBenefit(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var benefit system.Benefit
	err := c.ShouldBindJSON(&benefit)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	benefit.UpdatedBy = utils.GetUserID(c)
	err = benefitService.UpdateBenefit(ctx, benefit)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindBenefit 用id查询权益等级
// @Tags Benefit
// @Summary 用id查询权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询权益等级"
// @Success 200 {object} response.Response{data=system.Benefit,msg=string} "查询成功"
// @Router /benefit/findBenefit [get]
func (benefitApi *BenefitApi) FindBenefit(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	rebenefit, err := benefitService.GetBenefit(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(rebenefit, c)
}

// GetBenefitList 分页获取权益等级列表
// @Tags Benefit
// @Summary 分页获取权益等级列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.BenefitSearch true "分页获取权益等级列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /benefit/getBenefitList [get]
func (benefitApi *BenefitApi) GetBenefitList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.BenefitSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := benefitService.GetBenefitInfoList(ctx, pageInfo)
	if err != nil {
		global.GVA_LOG.Error("获取失败!", zap.Error(err))
		response.FailWithMessage("获取失败:"+err.Error(), c)
		return
	}
	response.OkWithDetailed(response.PageResult{
		List:     list,
		Total:    total,
		Page:     pageInfo.Page,
		PageSize: pageInfo.PageSize,
	}, "获取成功", c)
}

// GetBenefitPublic 不需要鉴权的权益等级接口
// @Tags Benefit
// @Summary 不需要鉴权的权益等级接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /benefit/getBenefitPublic [get]
func (benefitApi *BenefitApi) GetBenefitPublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	benefitService.GetBenefitPublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的权益等级接口信息",
	}, "获取成功", c)
}
