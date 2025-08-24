package system

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/system"
	systemReq "github.com/flipped-aurora/gin-vue-admin/server/model/system/request"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type BannerApi struct{}

// CreateBanner 创建轮播管理
// @Tags Banner
// @Summary 创建轮播管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Banner true "创建轮播管理"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /banner/createBanner [post]
func (bannerApi *BannerApi) CreateBanner(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var banner system.Banner
	err := c.ShouldBindJSON(&banner)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = bannerService.CreateBanner(ctx, &banner)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteBanner 删除轮播管理
// @Tags Banner
// @Summary 删除轮播管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Banner true "删除轮播管理"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /banner/deleteBanner [delete]
func (bannerApi *BannerApi) DeleteBanner(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	err := bannerService.DeleteBanner(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteBannerByIds 批量删除轮播管理
// @Tags Banner
// @Summary 批量删除轮播管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /banner/deleteBannerByIds [delete]
func (bannerApi *BannerApi) DeleteBannerByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	err := bannerService.DeleteBannerByIds(ctx, IDs)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateBanner 更新轮播管理
// @Tags Banner
// @Summary 更新轮播管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Banner true "更新轮播管理"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /banner/updateBanner [put]
func (bannerApi *BannerApi) UpdateBanner(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var banner system.Banner
	err := c.ShouldBindJSON(&banner)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = bannerService.UpdateBanner(ctx, banner)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindBanner 用id查询轮播管理
// @Tags Banner
// @Summary 用id查询轮播管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询轮播管理"
// @Success 200 {object} response.Response{data=system.Banner,msg=string} "查询成功"
// @Router /banner/findBanner [get]
func (bannerApi *BannerApi) FindBanner(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	rebanner, err := bannerService.GetBanner(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(rebanner, c)
}

// GetBannerList 分页获取轮播管理列表
// @Tags Banner
// @Summary 分页获取轮播管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.BannerSearch true "分页获取轮播管理列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /banner/getBannerList [get]
func (bannerApi *BannerApi) GetBannerList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.BannerSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := bannerService.GetBannerInfoList(ctx, pageInfo)
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

// GetBannerPublic 不需要鉴权的轮播管理接口
// @Tags Banner
// @Summary 不需要鉴权的轮播管理接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.BannerSearch true "分页获取轮播管理列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /banner/getBannerPublic [get]
func (bannerApi *BannerApi) GetBannerPublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()
	
	// 获取查询参数
	bannerType := c.DefaultQuery("type", "home") // 默认获取home类型的轮播图
	
	// 调用bannerService获取轮播图数据
	banners, err := bannerService.GetBannerPublic(ctx, bannerType)
	if err != nil {
		global.GVA_LOG.Error("获取轮播图失败!", zap.Error(err))
		response.FailWithMessage("获取轮播图失败: "+err.Error(), c)
		return
	}
	
	response.OkWithDetailed(gin.H{
		"banners": banners,
	}, "获取成功", c)
}
