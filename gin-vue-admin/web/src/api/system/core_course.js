import service from '@/utils/request'
// @Tags Course
// @Summary 创建课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Course true "创建课程管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /course/createCourse [post]
export const createCourse = (data) => {
  return service({
    url: '/course/createCourse',
    method: 'post',
    data
  })
}

// @Tags Course
// @Summary 删除课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Course true "删除课程管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /course/deleteCourse [delete]
export const deleteCourse = (params) => {
  return service({
    url: '/course/deleteCourse',
    method: 'delete',
    params
  })
}

// @Tags Course
// @Summary 批量删除课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除课程管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /course/deleteCourse [delete]
export const deleteCourseByIds = (params) => {
  return service({
    url: '/course/deleteCourseByIds',
    method: 'delete',
    params
  })
}

// @Tags Course
// @Summary 更新课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Course true "更新课程管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /course/updateCourse [put]
export const updateCourse = (data) => {
  return service({
    url: '/course/updateCourse',
    method: 'put',
    data
  })
}

// @Tags Course
// @Summary 用id查询课程管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.Course true "用id查询课程管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /course/findCourse [get]
export const findCourse = (params) => {
  return service({
    url: '/course/findCourse',
    method: 'get',
    params
  })
}

// @Tags Course
// @Summary 分页获取课程管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取课程管理列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /course/getCourseList [get]
export const getCourseList = (params) => {
  return service({
    url: '/course/getCourseList',
    method: 'get',
    params
  })
}
// @Tags Course
// @Summary 获取数据源
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /course/findCourseDataSource [get]
export const getCourseDataSource = () => {
  return service({
    url: '/course/getCourseDataSource',
    method: 'get',
  })
}

// @Tags Course
// @Summary 不需要鉴权的课程管理接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.CourseSearch true "分页获取课程管理列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /course/getCoursePublic [get]
export const getCoursePublic = () => {
  return service({
    url: '/course/getCoursePublic',
    method: 'get',
  })
}
