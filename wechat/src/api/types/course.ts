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
  salesperson?: string // 销售员ID
}

export interface WxCourseListParams {
  page?: number
  pageSize?: number
  hot?: boolean
  exquisite?: boolean
  category?: number
  keyword?: string // 标题搜索关键词
}

export interface WxCourseListResponse {
  courses: WxCourseItem[]
  total: number
  page: number
  pageSize: number
}

// 课程详情接口类型
export interface WxCourseDetailItem {
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
  courseDetails: string // 课程详情内容
  teacherInfo?: WxCourseTeacherInfo // 讲师信息（可选）
}

// 课程详情中的讲师信息
export interface WxCourseTeacherInfo {
  id: number
  avatar: string
  name: string
  description: string
  introduction: string
}

// 微信小程序分类相关类型定义
export interface WxCategoryItem {
  id: number
  categoryName: string
  status: boolean
  sortOrder: number
  type: string
  children: WxCategoryItem[]
  parentID: number
}

export interface WxCategoryListParams {
  type?: string // 分类类型，如 course、activity 等
}

export interface WxCategoryListResponse {
  categories: WxCategoryItem[]
}
