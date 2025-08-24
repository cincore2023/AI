/**
 * 教师项目
 */
export interface ITeacherItem {
  id: number
  avatar: string
  name: string
  description: string
  introduction: string
  sort: number
}

/**
 * 教师响应数据
 */
export interface ITeacherResponse {
  teachers: ITeacherItem[]
}

/**
 * 课程项目
 */
export interface ICourseItem {
  id: number
  courseTitle: string
  coverImage: string
  type: string
  price: number
  originalPrice: number
  onSale: boolean
  sort: number
  viewDetails: string
  courseDetails: string
  apprenticeCount: number
}

/**
 * 教师详情项目
 */
export interface ITeacherDetailItem {
  id: number
  avatar: string
  name: string
  description: string
  introduction: string
  sort: number
  courses: ICourseItem[]
}

/**
 * 教师详情响应数据
 */
export interface ITeacherDetailResponse {
  teacher: ITeacherDetailItem
}