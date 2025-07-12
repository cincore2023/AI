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

type ActivitiesApi struct{}

// CreateActivities 创建活动管理
// @Tags Activities
// @Summary 创建活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Activities true "创建活动管理"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /activities/createActivities [post]
func (activitiesApi *ActivitiesApi) CreateActivities(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var activities system.Activities
	err := c.ShouldBindJSON(&activities)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	activities.CreatedBy = utils.GetUserID(c)
	err = activitiesService.CreateActivities(ctx, &activities)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteActivities 删除活动管理
// @Tags Activities
// @Summary 删除活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Activities true "删除活动管理"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /activities/deleteActivities [delete]
func (activitiesApi *ActivitiesApi) DeleteActivities(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := activitiesService.DeleteActivities(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteActivitiesByIds 批量删除活动管理
// @Tags Activities
// @Summary 批量删除活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /activities/deleteActivitiesByIds [delete]
func (activitiesApi *ActivitiesApi) DeleteActivitiesByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := activitiesService.DeleteActivitiesByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateActivities 更新活动管理
// @Tags Activities
// @Summary 更新活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Activities true "更新活动管理"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /activities/updateActivities [put]
func (activitiesApi *ActivitiesApi) UpdateActivities(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var activities system.Activities
	err := c.ShouldBindJSON(&activities)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	activities.UpdatedBy = utils.GetUserID(c)
	err = activitiesService.UpdateActivities(ctx, activities)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindActivities 用id查询活动管理
// @Tags Activities
// @Summary 用id查询活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询活动管理"
// @Success 200 {object} response.Response{data=system.Activities,msg=string} "查询成功"
// @Router /activities/findActivities [get]
func (activitiesApi *ActivitiesApi) FindActivities(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	reactivities, err := activitiesService.GetActivities(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(reactivities, c)
}

// GetActivitiesList 分页获取活动管理列
// GetActivitiesList 分页获取活动管理列表
// @Tags Activities
// @Summary 分页获取活动管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.ActivitiesSearch true "分页获取活动管理列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /activities/getActivitiesList [get]
	// 创建业务用Context
	ctx := c.Request.Context()
    ctx := c.Request.Context()

	var pageInfo systemReq.ActivitiesSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	list, total, err := activitiesService.GetActivitiesInfoList(ctx, pageInfo)
	list, total, err := activitiesService.GetActivitiesInfoList(ctx,pageInfo)
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
    }, "获取成功", c)
i
}
// GetActivitiesDataSource 获取Activities的数据源
// @Tags Activities
// @Summary 获取Activities的数据源
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "查询成功"
// @Router /activities/getActivitiesDataSource [get]
	// 创建业务用Context
	ctx := c.Request.Context()
    ctx := c.Request.Context()
	// 此接口为获取数据源定义的数据
	dataSource, err := activitiesService.GetActivitiesDataSource(ctx)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(dataSource, c)
   response.OkWithData(dataSource, c)
}

// GetActivitiesPublic 不需要鉴权的活动管理接口
// @Tags Activities
// @Summary 不需要鉴权的活动管理接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /activities/getActivitiesPublic [get]
	// 创建业务用Context
	ctx := c.Request.Context()
    ctx := c.Request.Context()
	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	activitiesService.GetActivitiesPublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的活动管理接口信息",
	}, "获取成功", c)
    }, "获取成功", c)
}
