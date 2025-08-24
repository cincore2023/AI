// 微信小程序课程相关类型定义
export interface WxCourseItem {
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
}

export interface WxCourseListParams {
  page?: number
  pageSize?: number
  hot?: boolean
  exquisite?: boolean
  category?: number
}

export interface WxCourseListResponse {
  courses: WxCourseItem[]
  total: number
  page: number
  pageSize: number
}
