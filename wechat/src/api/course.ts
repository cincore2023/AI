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

// 微信小程序获取用户收藏课程列表API
export function getWxFavoriteCourses(params: { page?: number; pageSize?: number } = {}) {
  return http.get<WxFavoriteCourseResponse>('/api/wx/Courses/favorite', params)
}

// 微信小程序收藏课程响应类型
export interface WxFavoriteCourseItem {
  id: number
  courseTitle: string
  coverImage: string
  type: string // 'img' | 'video'
  price: number
  originalPrice: number
  onSale: boolean
  hot: boolean
  exquisite: boolean
  sort: number
  viewDetails: string
  apprenticeCount: number
  teacher: number
  category: number
  salesperson?: string // 销售员ID
  favoriteTime: string // 收藏时间
}

export interface WxFavoriteCourseResponse {
  courses: WxFavoriteCourseItem[]
  total: number
  page: number
  pageSize: number
}