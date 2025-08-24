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

type TeacherApi struct{}

// CreateTeacher 创建讲师管理
// @Tags Teacher
// @Summary 创建讲师管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Teacher true "创建讲师管理"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /teacher/createTeacher [post]
func (teacherApi *TeacherApi) CreateTeacher(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var teacher system.Teacher
	err := c.ShouldBindJSON(&teacher)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	teacher.CreatedBy = utils.GetUserID(c)
	err = teacherService.CreateTeacher(ctx, &teacher)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteTeacher 删除讲师管理
// @Tags Teacher
// @Summary 删除讲师管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Teacher true "删除讲师管理"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /teacher/deleteTeacher [delete]
func (teacherApi *TeacherApi) DeleteTeacher(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := teacherService.DeleteTeacher(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteTeacherByIds 批量删除讲师管理
// @Tags Teacher
// @Summary 批量删除讲师管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /teacher/deleteTeacherByIds [delete]
func (teacherApi *TeacherApi) DeleteTeacherByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := teacherService.DeleteTeacherByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateTeacher 更新讲师管理
// @Tags Teacher
// @Summary 更新讲师管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Teacher true "更新讲师管理"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /teacher/updateTeacher [put]
func (teacherApi *TeacherApi) UpdateTeacher(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var teacher system.Teacher
	err := c.ShouldBindJSON(&teacher)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	teacher.UpdatedBy = utils.GetUserID(c)
	err = teacherService.UpdateTeacher(ctx, teacher)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindTeacher 用id查询讲师管理
// @Tags Teacher
// @Summary 用id查询讲师管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询讲师管理"
// @Success 200 {object} response.Response{data=system.Teacher,msg=string} "查询成功"
// @Router /teacher/findTeacher [get]
func (teacherApi *TeacherApi) FindTeacher(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	reteacher, err := teacherService.GetTeacher(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(reteacher, c)
}

// GetTeacherList 分页获取讲师管理列表
// @Tags Teacher
// @Summary 分页获取讲师管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.TeacherSearch true "分页获取讲师管理列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /teacher/getTeacherList [get]
func (teacherApi *TeacherApi) GetTeacherList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.TeacherSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := teacherService.GetTeacherInfoList(ctx, pageInfo)
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

// GetTeacherPublic 不需要鉴权的讲师管理接口
// @Tags Teacher
// @Summary 不需要鉴权的讲师管理接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /teacher/getTeacherPublic [get]
func (teacherApi *TeacherApi) GetTeacherPublic(c *gin.Context) {

	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	teacherService.GetTeacherPublic()
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的讲师管理接口信息",
	}, "获取成功", c)
}
