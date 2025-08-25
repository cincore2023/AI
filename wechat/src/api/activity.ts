import type { WxActivityDetailItem, WxActivityListParams, WxActivityListResponse } from '@/api/types/activity'
import { http } from '@/http/http'

// 微信小程序活动API
export function getWxActivityList(params: WxActivityListParams = {}) {
  return http.get<WxActivityListResponse>('/api/wx/Activities', params)
}

// 微信小程序活动详情API
export function getWxActivityDetail(id: number | string) {
  return http.get<WxActivityDetailItem>(`/api/wx/Activities/${id}`)
}
