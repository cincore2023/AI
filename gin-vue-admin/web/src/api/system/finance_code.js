import service from '@/utils/request'
// @Tags Code
// @Summary 创建兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Code true "创建兑换码明细"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /code/createCode [post]
export const createCode = (data) => {
  return service({
    url: '/code/createCode',
    method: 'post',
    data
  })
}

// @Tags Code
// @Summary 删除兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Code true "删除兑换码明细"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /code/deleteCode [delete]
export const deleteCode = (params) => {
  return service({
    url: '/code/deleteCode',
    method: 'delete',
    params
  })
}

// @Tags Code
// @Summary 批量删除兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除兑换码明细"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /code/deleteCode [delete]
export const deleteCodeByIds = (params) => {
  return service({
    url: '/code/deleteCodeByIds',
    method: 'delete',
    params
  })
}

// @Tags Code
// @Summary 更新兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Code true "更新兑换码明细"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /code/updateCode [put]
export const updateCode = (data) => {
  return service({
    url: '/code/updateCode',
    method: 'put',
    data
  })
}

// @Tags Code
// @Summary 用id查询兑换码明细
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.Code true "用id查询兑换码明细"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /code/findCode [get]
export const findCode = (params) => {
  return service({
    url: '/code/findCode',
    method: 'get',
    params
  })
}

// @Tags Code
// @Summary 分页获取兑换码明细列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取兑换码明细列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /code/getCodeList [get]
export const getCodeList = (params) => {
  return service({
    url: '/code/getCodeList',
    method: 'get',
    params
  })
}

// @Tags Code
// @Summary 不需要鉴权的兑换码明细接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.CodeSearch true "分页获取兑换码明细列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /code/getCodePublic [get]
export const getCodePublic = () => {
  return service({
    url: '/code/getCodePublic',
    method: 'get',
  })
}
