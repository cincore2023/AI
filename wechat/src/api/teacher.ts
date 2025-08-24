import type { ITeacherResponse, ITeacherDetailResponse } from './types/teacher'
import { http } from '@/http/http'

/**
 * 获取教师列表
 * @param sort 排序方式（asc/desc），默认为 desc
 * @returns Promise<ITeacherResponse> 教师数据
 */
export function getTeachers(sort: 'asc' | 'desc' = 'desc') {
  return http.get<ITeacherResponse>('/api/wxTeachers', {
    params: { sort }
  })
}

/**
 * 获取教师详情
 * @param id 教师ID
 * @returns Promise<ITeacherDetailResponse> 教师详情数据（包含课程列表）
 */
export function getTeacherDetail(id: number | string) {
  return http.get<ITeacherDetailResponse>(`/api/wxTeachers/${id}`)
}
