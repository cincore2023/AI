import type { WxCategoryListResponse, WxCourseDetailItem, WxCourseListParams, WxCourseListResponse } from '@/api/types/course'
import { http } from '@/http/http'

// 微信小程序课程API
export function getWxCourseList(params: WxCourseListParams = {}) {
  return http.get<WxCourseListResponse>('/api/wx/Courses', params)
}

// 微信小程序课程详情API
export function getWxCourseDetail(id: number | string) {
  return http.get<WxCourseDetailItem>(`/api/wx/Courses/${id}`)
}

// 微信小程序分类API
export function getWxCategoryList() {
  return http.get<WxCategoryListResponse>('/api/wx/Categories')
}

// 微信小程序课程收藏API
export function toggleWxCourseFavorite(courseId: number) {
  return http.post<{ isFavorite: boolean }>(`/api/wx/Courses/favorite`, { courseId })
}

// 微信小程序检查课程是否已收藏API
export function getWxCourseFavoriteStatus(courseId: number) {
  return http.get<{ isFavorite: boolean }>(`/api/wx/Courses/${courseId}/favorite`)
}