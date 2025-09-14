import type {
  WxActivityDetailItem,
  WxActivityListParams,
  WxActivityListResponse,
  WxUserRegisteredActivitiesResponse,
} from '@/api/types/activity'
import type { WxActivityRegistrationResponse } from '@/api/types/activityRegistration'
import { http } from '@/http/http'

// 微信小程序活动API
export function getWxActivityList(params: WxActivityListParams = {}) {
  return http.get<WxActivityListResponse>('/api/wx/Activities', params)
}

// 微信小程序活动详情API
export function getWxActivityDetail(id: number | string) {
  return http.get<WxActivityDetailItem>(`/api/wx/Activities/${id}`)
}

// 活动报名
export function wxRegisterForActivity(activityID: number) {
  return http.post('/api/wx/Activities/register', { activityID })
}

// 创建活动支付订单
export function wxCreateActivityOrder(activityID: number) {
  return http.post<{
    registrationID: number
    appId: string
    timeStamp: string
    nonceStr: string
    package: string
    signType: string
    paySign: string
    amount: number
    orderNo: string
  }>('/api/wx/Activities/create-order', { activityID })
}

// 获取活动报名状态
export function wxGetActivityRegistrationStatus(activityID: number) {
  return http.get<WxActivityRegistrationResponse>('/api/wx/Activities/registration-status', { activityID })
}

// 获取用户已报名活动列表
export function wxGetUserRegisteredActivities(params: {
  page?: number
  pageSize?: number
  paymentStatus?: string
  startTimeRange?: string
} = {}) {
  return http.get<WxUserRegisteredActivitiesResponse>('/api/wx/Activities/registered', params)
}

// 更新参与者信息
export function wxUpdateParticipantInfo(data: {
  registrationID: number
  participantName: string
  participantPhone: string
}) {
  return http.post('/api/wx/Activities/participant-info', data)
}

// 合伙人兑换码报名
export function wxPartnerRedemptionCode(activityID: number) {
  return http.post('/api/wx/Activities/partner-redemption', { activityID })
}
