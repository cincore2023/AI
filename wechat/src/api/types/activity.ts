// 微信小程序活动相关类型定义

export interface WxActivityItem {
  id: number
  activityName: string
  price: number
  category: number
  coverPicture: string
  actualEnrollment: number
  sortOrder: number
  startTime: string
  endTime: string
  showStartTime: string
  showEndTime: string
}

export interface WxActivityListParams {
  page?: number
  pageSize?: number
  category?: number
  keyword?: string // 活动名称搜索关键词
}

export interface WxActivityListResponse {
  activities: WxActivityItem[]
  total: number
  page: number
  pageSize: number
}

// 活动详情接口类型
export interface WxActivityDetailItem {
  id: number
  activityName: string
  price: number
  category: number
  coverPicture: string
  actualEnrollment: number
  sortOrder: number
  startTime: string
  endTime: string
  showStartTime: string
  showEndTime: string
}