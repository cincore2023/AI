// 微信小程序活动相关类型定义

export interface WxActivityItem {
  id: number
  activityName: string
  price: number
  category: number
  coverPicture: string
  actualEnrollment: number
  realEnrollment?: number // 真实报名人数
  sortOrder: number
  startTime: string
  endTime: string
  showStartTime: string
  showEndTime: string
  registrationType?: string // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
  salesperson?: string
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
  realEnrollment?: number // 真实报名人数
  sortOrder: number
  startTime: string
  endTime: string
  showStartTime: string
  showEndTime: string
  details: string
  registrationType?: string // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
  salesperson?: string
}