package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type PosterApi struct{}

// CreatePoster 创建推广海报
// @Tags Poster
// @Summary 创建推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Poster true "创建推广海报"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /poster/createPoster [post]
func (posterApi *PosterApi) CreatePoster(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var poster system.Poster
	err := c.ShouldBindJSON(&poster)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = posterService.CreatePoster(ctx, &poster)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeletePoster 删除推广海报
// @Tags Poster
// @Summary 删除推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Poster true "删除推广海报"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /poster/deletePoster [delete]
func (posterApi *PosterApi) DeletePoster(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	err := posterService.DeletePoster(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeletePosterByIds 批量删除推广海报
// @Tags Poster
// @Summary 批量删除推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /poster/deletePosterByIds [delete]
func (posterApi *PosterApi) DeletePosterByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	err := posterService.DeletePosterByIds(ctx, IDs)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdatePoster 更新推广海报
// @Tags Poster
// @Summary 更新推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Poster true "更新推广海报"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /poster/updatePoster [put]
func (posterApi *PosterApi) UpdatePoster(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var poster system.Poster
	err := c.ShouldBindJSON(&poster)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = posterService.UpdatePoster(ctx, poster)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindPoster 用id查询推广海报
// @Tags Poster
// @Summary 用id查询推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询推广海报"
// @Success 200 {object} response.Response{data=system.Poster,msg=string} "查询成功"
// @Router /poster/findPoster [get]
func (posterApi *PosterApi) FindPoster(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	reposter, err := posterService.GetPoster(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(reposter, c)
}

// GetPosterList 分页获取推广海报列表
// @Tags Poster
// @Summary 分页获取推广海报列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.PosterSearch true "分页获取推广海报列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /poster/getPosterList [get]
func (posterApi *PosterApi) GetPosterList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.PosterSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := posterService.GetPosterInfoList(ctx, pageInfo)
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

// GetPosterPublic 不需要鉴权的推广海报接口
// @Tags Poster
// @Summary 不需要鉴权的推广海报接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /poster/getPosterPublic [get]
func (posterApi *PosterApi) GetPosterPublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	posterService.GetPosterPublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的推广海报接口信息",
	}, "获取成功", c)
}
