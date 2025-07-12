import service from '@/utils/request'
// @Tags Activities
// @Summary 创建活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Activities true "创建活动管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /activities/createActivities [post]
export const createActivities = (data) => {
  return service({
    url: '/activities/createActivities',
    method: 'post',
    data
  })
}

// @Tags Activities
// @Summary 删除活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Activities true "删除活动管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /activities/deleteActivities [delete]
export const deleteActivities = (params) => {
  return service({
    url: '/activities/deleteActivities',
    method: 'delete',
    params
  })
}

// @Tags Activities
// @Summary 批量删除活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除活动管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /activities/deleteActivities [delete]
export const deleteActivitiesByIds = (params) => {
  return service({
    url: '/activities/deleteActivitiesByIds',
    method: 'delete',
    params
  })
}

// @Tags Activities
// @Summary 更新活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Activities true "更新活动管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /activities/updateActivities [put]
export const updateActivities = (data) => {
  return service({
    url: '/activities/updateActivities',
    method: 'put',
    data
  })
}

// @Tags Activities
// @Summary 用id查询活动管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.Activities true "用id查询活动管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /activities/findActivities [get]
export const findActivities = (params) => {
  return service({
    url: '/activities/findActivities',
    method: 'get',
    params
  })
}

// @Tags Activities
// @Summary 分页获取活动管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取活动管理列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /activities/getActivitiesList [get]
export const getActivitiesList = (params) => {
  return service({
    url: '/activities/getActivitiesList',
    method: 'get',
    params
  })
}
// @Tags Activities
// @Summary 获取数据源
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /activities/findActivitiesDataSource [get]
export const getActivitiesDataSource = () => {
  return service({
    url: '/activities/getActivitiesDataSource',
    method: 'get',
  })
}

// @Tags Activities
// @Summary 不需要鉴权的活动管理接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.ActivitiesSearch true "分页获取活动管理列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /activities/getActivitiesPublic [get]
export const getActivitiesPublic = () => {
  return service({
    url: '/activities/getActivitiesPublic',
    method: 'get',
  })
}
