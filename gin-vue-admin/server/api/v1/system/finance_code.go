package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type CodeApi struct{}

// CreateCode 创建兑换码明细
// @Tags Code
// @Summary 创建兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Code true "创建兑换码明细"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /code/createCode [post]
func (codeApi *CodeApi) CreateCode(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var code system.Code
	err := c.ShouldBindJSON(&code)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = codeService.CreateCode(ctx, &code)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteCode 删除兑换码明细
// @Tags Code
// @Summary 删除兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Code true "删除兑换码明细"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /code/deleteCode [delete]
func (codeApi *CodeApi) DeleteCode(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	err := codeService.DeleteCode(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteCodeByIds 批量删除兑换码明细
// @Tags Code
// @Summary 批量删除兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /code/deleteCodeByIds [delete]
func (codeApi *CodeApi) DeleteCodeByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	err := codeService.DeleteCodeByIds(ctx, IDs)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateCode 更新兑换码明细
// @Tags Code
// @Summary 更新兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Code true "更新兑换码明细"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /code/updateCode [put]
func (codeApi *CodeApi) UpdateCode(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var code system.Code
	err := c.ShouldBindJSON(&code)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = codeService.UpdateCode(ctx, code)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindCode 用id查询兑换码明细
// @Tags Code
// @Summary 用id查询兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询兑换码明细"
// @Success 200 {object} response.Response{data=system.Code,msg=string} "查询成功"
// @Router /code/findCode [get]
func (codeApi *CodeApi) FindCode(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	recode, err := codeService.GetCode(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(recode, c)
}

// GetCodeList 分页获取兑换码明细列表
// @Tags Code
// @Summary 分页获取兑换码明细列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.CodeSearch true "分页获取兑换码明细列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /code/getCodeList [get]
func (codeApi *CodeApi) GetCodeList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.CodeSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := codeService.GetCodeInfoList(ctx, pageInfo)
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

// GetCodePublic 不需要鉴权的兑换码明细接口
// @Tags Code
// @Summary 不需要鉴权的兑换码明细接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /code/getCodePublic [get]
func (codeApi *CodeApi) GetCodePublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	codeService.GetCodePublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的兑换码明细接口信息",
	}, "获取成功", c)
}
