import service from '@/utils/request'
// @Tags Benefit
// @Summary 创建权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Benefit true "创建权益等级"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /benefit/createBenefit [post]
export const createBenefit = (data) => {
  return service({
    url: '/benefit/createBenefit',
    method: 'post',
    data
  })
}

// @Tags Benefit
// @Summary 删除权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Benefit true "删除权益等级"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /benefit/deleteBenefit [delete]
export const deleteBenefit = (params) => {
  return service({
    url: '/benefit/deleteBenefit',
    method: 'delete',
    params
  })
}

// @Tags Benefit
// @Summary 批量删除权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除权益等级"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /benefit/deleteBenefit [delete]
export const deleteBenefitByIds = (params) => {
  return service({
    url: '/benefit/deleteBenefitByIds',
    method: 'delete',
    params
  })
}

// @Tags Benefit
// @Summary 更新权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Benefit true "更新权益等级"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /benefit/updateBenefit [put]
export const updateBenefit = (data) => {
  return service({
    url: '/benefit/updateBenefit',
    method: 'put',
    data
  })
}

// @Tags Benefit
// @Summary 用id查询权益等级
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.Benefit true "用id查询权益等级"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /benefit/findBenefit [get]
export const findBenefit = (params) => {
  return service({
    url: '/benefit/findBenefit',
    method: 'get',
    params
  })
}

// @Tags Benefit
// @Summary 分页获取权益等级列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取权益等级列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /benefit/getBenefitList [get]
export const getBenefitList = (params) => {
  return service({
    url: '/benefit/getBenefitList',
    method: 'get',
    params
  })
}

// @Tags Benefit
// @Summary 不需要鉴权的权益等级接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.BenefitSearch true "分页获取权益等级列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /benefit/getBenefitPublic [get]
export const getBenefitPublic = () => {
  return service({
    url: '/benefit/getBenefitPublic',
    method: 'get',
  })
}
