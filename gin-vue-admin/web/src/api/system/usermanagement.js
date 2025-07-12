import service from '@/utils/request'
// @Tags WechatUser
// @Summary 创建用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.WechatUser true "创建用户管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /wxUser/createWechatUser [post]
export const createWechatUser = (data) => {
  return service({
    url: '/wxUser/createWechatUser',
    method: 'post',
    data
  })
}

// @Tags WechatUser
// @Summary 删除用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.WechatUser true "删除用户管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /wxUser/deleteWechatUser [delete]
export const deleteWechatUser = (params) => {
  return service({
    url: '/wxUser/deleteWechatUser',
    method: 'delete',
    params
  })
}

// @Tags WechatUser
// @Summary 批量删除用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除用户管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /wxUser/deleteWechatUser [delete]
export const deleteWechatUserByIds = (params) => {
  return service({
    url: '/wxUser/deleteWechatUserByIds',
    method: 'delete',
    params
  })
}

// @Tags WechatUser
// @Summary 更新用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.WechatUser true "更新用户管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /wxUser/updateWechatUser [put]
export const updateWechatUser = (data) => {
  return service({
    url: '/wxUser/updateWechatUser',
    method: 'put',
    data
  })
}

// @Tags WechatUser
// @Summary 用id查询用户管理
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.WechatUser true "用id查询用户管理"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /wxUser/findWechatUser [get]
export const findWechatUser = (params) => {
  return service({
    url: '/wxUser/findWechatUser',
    method: 'get',
    params
  })
}

// @Tags WechatUser
// @Summary 分页获取用户管理列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取用户管理列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /wxUser/getWechatUserList [get]
export const getWechatUserList = (params) => {
  return service({
    url: '/wxUser/getWechatUserList',
    method: 'get',
    params
  })
}

// @Tags WechatUser
// @Summary 不需要鉴权的用户管理接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.WechatUserSearch true "分页获取用户管理列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /wxUser/getWechatUserPublic [get]
export const getWechatUserPublic = () => {
  return service({
    url: '/wxUser/getWechatUserPublic',
    method: 'get',
  })
}
