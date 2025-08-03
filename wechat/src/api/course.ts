import { http } from '@/http/http'

export interface Chapter {
  title: string
  duration: string
}

export interface Instructor {
  name: string
  title: string
  avatar: string
  bio: string
}

export interface Material {
  name: string
  size: string
  url: string
}

export interface Course {
  id: string
  title: string
  description: string
  image: string
  price: number
  studentCount: number
  status: 'active' | 'inactive' | 'draft'
  category: string
  createdAt: string
  updatedAt: string
}

export interface CourseDetail extends Course {
  chapters: Chapter[]
  instructor: Instructor
  materials: Material[]
}

export interface CreateCourseRequest {
  title: string
  description: string
  image: string
  price: number
  category: string
  status: 'active' | 'inactive' | 'draft'
}

export interface UpdateCourseRequest extends Partial<CreateCourseRequest> {
  id: string
}

export interface CourseListResponse {
  list: Course[]
  total: number
  page: number
  pageSize: number
}

export interface CourseListParams {
  page?: number
  pageSize?: number
  status?: string
  category?: string
  keyword?: string
}

// 获取课程列表
export const getCourseList = (params: CourseListParams = {}) => {
  return http.get<CourseListResponse>('/api/courses', { params })
}

// 获取课程详情
export const getCourseDetail = (id: string) => {
  return http.get<CourseDetail>(`/api/courses/${id}`)
}

// 创建课程
export const createCourse = (data: CreateCourseRequest) => {
  return http.post<Course>('/api/courses', data)
}

// 更新课程
export const updateCourse = (data: UpdateCourseRequest) => {
  const { id, ...updateData } = data
  return http.put<Course>(`/api/courses/${id}`, updateData)
}

// 删除课程
export const deleteCourse = (id: string) => {
  return http.delete(`/api/courses/${id}`)
}

// 更新课程状态
export const updateCourseStatus = (id: string, status: Course['status']) => {
  return http.put<Course>(`/api/courses/${id}/status`, { status })
}

// 上传课程图片
export const uploadCourseImage = (file: File) => {
  const formData = new FormData()
  formData.append('file', file)
  return http.post<{ url: string }>('/api/upload/course-image', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
} 