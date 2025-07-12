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

type CourseApi struct{}

// CreateCourse 创建课程管理
// @Tags Course
// @Summary 创建课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Course true "创建课程管理"
// @Success 200 {object} response.Response{msg=string} "创建成功"
// @Router /course/createCourse [post]
func (courseApi *CourseApi) CreateCourse(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var course system.Course
	err := c.ShouldBindJSON(&course)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	course.CreatedBy = utils.GetUserID(c)
	err = courseService.CreateCourse(ctx, &course)
	if err != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

// DeleteCourse 删除课程管理
// @Tags Course
// @Summary 删除课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Course true "删除课程管理"
// @Success 200 {object} response.Response{msg=string} "删除成功"
// @Router /course/deleteCourse [delete]
func (courseApi *CourseApi) DeleteCourse(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	userID := utils.GetUserID(c)
	err := courseService.DeleteCourse(ctx, ID, userID)
	if err != nil {
		global.GVA_LOG.Error("删除失败!", zap.Error(err))
		response.FailWithMessage("删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

// DeleteCourseByIds 批量删除课程管理
// @Tags Course
// @Summary 批量删除课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{msg=string} "批量删除成功"
// @Router /course/deleteCourseByIds [delete]
func (courseApi *CourseApi) DeleteCourseByIds(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	IDs := c.QueryArray("IDs[]")
	userID := utils.GetUserID(c)
	err := courseService.DeleteCourseByIds(ctx, IDs, userID)
	if err != nil {
		global.GVA_LOG.Error("批量删除失败!", zap.Error(err))
		response.FailWithMessage("批量删除失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("批量删除成功", c)
}

// UpdateCourse 更新课程管理
// @Tags Course
// @Summary 更新课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body system.Course true "更新课程管理"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /course/updateCourse [put]
func (courseApi *CourseApi) UpdateCourse(c *gin.Context) {
	// 从ctx获取标准context进行业务行为
	ctx := c.Request.Context()

	var course system.Course
	err := c.ShouldBindJSON(&course)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	course.UpdatedBy = utils.GetUserID(c)
	err = courseService.UpdateCourse(ctx, course)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// FindCourse 用id查询课程管理
// @Tags Course
// @Summary 用id查询课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param ID query uint true "用id查询课程管理"
// @Success 200 {object} response.Response{data=system.Course,msg=string} "查询成功"
// @Router /course/findCourse [get]
func (courseApi *CourseApi) FindCourse(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	ID := c.Query("ID")
	recourse, err := courseService.GetCourse(ctx, ID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(recourse, c)
}

// GetCourseList 分页获取课程管理列表
// @Tags Course
// @Summary 分页获取课程管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.CourseSearch true "分页获取课程管理列表"
// @Success 200 {object} response.Response{data=response.PageResult,msg=string} "获取成功"
// @Router /course/getCourseList [get]
func (courseApi *CourseApi) GetCourseList(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	var pageInfo systemReq.CourseSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := courseService.GetCourseInfoList(ctx, pageInfo)
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

// GetCourseDataSource 获取Course的数据源
// @Tags Course
// @Summary 获取Course的数据源
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "查询成功"
// @Router /course/getCourseDataSource [get]
func (courseApi *CourseApi) GetCourseDataSource(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口为获取数据源定义的数据
	dataSource, err := courseService.GetCourseDataSource(ctx)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败:"+err.Error(), c)
		return
	}
	response.OkWithData(dataSource, c)
}

// GetCoursePublic 不需要鉴权的课程管理接口
// @Tags Course
// @Summary 不需要鉴权的课程管理接口
// @Accept application/json
// @Produce application/json
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /course/getCoursePublic [get]
func (courseApi *CourseApi) GetCoursePublic(c *gin.Context) {
	// 创建业务用Context
	ctx := c.Request.Context()

	// 此接口不需要鉴权
	// 示例为返回了一个固定的消息接口，一般本接口用于C端服务，需要自己实现业务逻辑
	courseService.GetCoursePublic(ctx)
	response.OkWithDetailed(gin.H{
		"info": "不需要鉴权的课程管理接口信息",
	}, "获取成功", c)
}
