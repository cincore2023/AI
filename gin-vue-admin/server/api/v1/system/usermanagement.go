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

type WechatUserApi struct{}

// CreateWechatUser 创建用户管理
// @Tags WechatUser
// @Summary 创建用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.WechatUser true "创建用户管理"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /wxUser/createWechatUser [post]
func (wxUserApi *WechatUserApi) CreateWechatUser(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var wxUser system.WechatUser
	err := c.ShouldBindJSON(&wxUser)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	wxUser.CreatedBy = utils.GetUserID(c)
	err = wxUserService.CreateWechatUser(ctx, &wxUser)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteWechatUser 删除用户管理
// @Tags WechatUser
// @Summary 删除用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.WechatUser true "删除用户管理"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /wxUser/deleteWechatUser [delete]
func (wxUserApi *WechatUserApi) DeleteWechatUser(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := wxUserService.DeleteWechatUser(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteWechatUserByIds 批量删除用户管理
// @Tags WechatUser
// @Summary 批量删除用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /wxUser/deleteWechatUserByIds [delete]
func (wxUserApi *WechatUserApi) DeleteWechatUserByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := wxUserService.DeleteWechatUserByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateWechatUser 更新用户管理
// @Tags WechatUser
// @Summary 更新用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.WechatUser true "更新用户管理"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /wxUser/updateWechatUser [put]
func (wxUserApi *WechatUserApi) UpdateWechatUser(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var wxUser system.WechatUser
	err := c.ShouldBindJSON(&wxUser)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	wxUser.UpdatedBy = utils.GetUserID(c)
	err = wxUserService.UpdateWechatUser(ctx, wxUser)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindWechatUser 用id查询用户管理
// @Tags WechatUser
// @Summary 用id查询用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询用户管理"
// @Success 200 {object} response.Response{data=system.WechatUser,msg=string} "查询成功"
// @Router /wxUser/findWechatUser [get]
func (wxUserApi *WechatUserApi) FindWechatUser(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	rewxUser, err := wxUserService.GetWechatUser(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(rewxUser, c)
}

// GetWechatUserList 分页获取用户管理列表
// @Tags WechatUser
// @Summary 分页获取用户管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.WechatUserSearch true "分页获取用户管理列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /wxUser/getWechatUserList [get]
func (wxUserApi *WechatUserApi) GetWechatUserList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.WechatUserSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := wxUserService.GetWechatUserInfoList(ctx, pageInfo)
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

// GetWechatUserPublic 不需要鉴权的用户管理接口
// @Tags WechatUser
// @Summary 不需要鉴权的用户管理接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /wxUser/getWechatUserPublic [get]
func (wxUserApi *WechatUserApi) GetWechatUserPublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	wxUserService.GetWechatUserPublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的用户管理接口信息",
	}, "获取成功", c)
}
