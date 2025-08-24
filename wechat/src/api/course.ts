import type { WxCategoryListResponse, WxCourseListParams, WxCourseListResponse } from '@/api/types/course'
import { http } from '@/http/http'

// 微信小程序课程API
export function getWxCourseList(params: WxCourseListParams = {}) {
  return http.get<WxCourseListResponse>('/api/wxCourses', params)
}

// 微信小程序分类API
export function getWxCategoryList() {
  return http.get<WxCategoryListResponse>('/api/wxCategories')
}
