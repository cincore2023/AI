package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type CategoryApi struct{}

// CreateCategory 创建分类
// @Tags Category
// @Summary 创建分类
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Category true "创建分类"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /category/createCategory [post]
func (categoryApi *CategoryApi) CreateCategory(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var category system.Category
	err := c.ShouldBindJSON(&category)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	category.CreatedBy = utils.GetUserID(c)
	err = categoryService.CreateCategory(ctx, &category)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteCategory 删除分类
// @Tags Category
// @Summary 删除分类
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Category true "删除分类"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /category/deleteCategory [delete]
func (categoryApi *CategoryApi) DeleteCategory(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := categoryService.DeleteCategory(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteCategoryByIds 批量删除分类
// @Tags Category
// @Summary 批量删除分类
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /category/deleteCategoryByIds [delete]
func (categoryApi *CategoryApi) DeleteCategoryByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := categoryService.DeleteCategoryByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateCategory 更新分类
// @Tags Category
// @Summary 更新分类
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Category true "更新分类"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /category/updateCategory [put]
func (categoryApi *CategoryApi) UpdateCategory(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var category system.Category
	err := c.ShouldBindJSON(&category)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	category.UpdatedBy = utils.GetUserID(c)
	err = categoryService.UpdateCategory(ctx, category)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindCategory 用id查询分类
// @Tags Category
// @Summary 用id查询分类
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询分类"
// @Success 200 {object} response.Response{data=system.Category,msg=string} "查询成功"
// @Router /category/findCategory [get]
func (categoryApi *CategoryApi) FindCategory(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	recategory, err := categoryService.GetCategory(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(recategory, c)
}

// GetCategoryList 分页获取分类列表,Tree模式下不接受参数
// @Tags Category
// @Summary 分页获取分类列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /category/getCategoryList [get]
func (categoryApi *CategoryApi) GetCategoryList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	list, err := categoryService.GetCategoryInfoList(ctx)
	if err != nil {
		global.GVA_LOG.Error("获取失败!", zap.Error(err))
		response.FailWithMessage("获取失败:"+err.Error(), c)
		return
	}
	response.OkWithDetailed(list, "获取成功", c)
}

// GetCategoryPublic 不需要鉴权的分类接口
// @Tags Category
// @Summary 不需要鉴权的分类接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /category/getCategoryPublic [get]
func (categoryApi *CategoryApi) GetCategoryPublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	categoryService.GetCategoryPublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的分类接口信息",
	}, "获取成功", c)
}
