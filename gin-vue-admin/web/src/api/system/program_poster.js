import service from '@/utils/request'
// @Tags Poster
// @Summary 创建推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Poster true "创建推广海报"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /poster/createPoster [post]
export const createPoster = (data) => {
  return service({
    url: '/poster/createPoster',
    method: 'post',
    data
  })
}

// @Tags Poster
// @Summary 删除推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Poster true "删除推广海报"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /poster/deletePoster [delete]
export const deletePoster = (params) => {
  return service({
    url: '/poster/deletePoster',
    method: 'delete',
    params
  })
}

// @Tags Poster
// @Summary 批量删除推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body request.IdsReq true "批量删除推广海报"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /poster/deletePoster [delete]
export const deletePosterByIds = (params) => {
  return service({
    url: '/poster/deletePosterByIds',
    method: 'delete',
    params
  })
}

// @Tags Poster
// @Summary 更新推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data body model.Poster true "更新推广海报"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /poster/updatePoster [put]
export const updatePoster = (data) => {
  return service({
    url: '/poster/updatePoster',
    method: 'put',
    data
  })
}

// @Tags Poster
// @Summary 用id查询推广海报
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query model.Poster true "用id查询推广海报"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /poster/findPoster [get]
export const findPoster = (params) => {
  return service({
    url: '/poster/findPoster',
    method: 'get',
    params
  })
}

// @Tags Poster
// @Summary 分页获取推广海报列表
// @Security ApiKeyAuth
// @Accept application/json
// @Produce application/json
// @Param data query request.PageInfo true "分页获取推广海报列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /poster/getPosterList [get]
export const getPosterList = (params) => {
  return service({
    url: '/poster/getPosterList',
    method: 'get',
    params
  })
}

// @Tags Poster
// @Summary 不需要鉴权的推广海报接口
// @Accept application/json
// @Produce application/json
// @Param data query systemReq.PosterSearch true "分页获取推广海报列表"
// @Success 200 {object} response.Response{data=object,msg=string} "获取成功"
// @Router /poster/getPosterPublic [get]
export const getPosterPublic = () => {
  return service({
    url: '/poster/getPosterPublic',
    method: 'get',
  })
}
