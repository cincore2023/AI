import type { WxCourseListParams, WxCourseListResponse } from '@/api/types/course'
import { http } from '@/http/http'

// 微信小程序课程API
export function getWxCourseList(params: WxCourseListParams = {}) {
  return http.get<WxCourseListResponse>('/api/wxCourses', params)
}
