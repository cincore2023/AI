// 活动报名请求参数
export interface WxActivityRegistrationRequest {
  activityID: number // 活动ID
}

// 参与者信息请求参数
export interface WxParticipantInfoRequest {
  registrationID: number // 报名ID
  participantName: string // 参与人姓名
  participantPhone: string // 参与人手机号
}

// 活动报名响应
export interface WxActivityRegistrationResponse {
  registrationID: number // 报名ID
  verificationCode: string // 核销码
  paymentStatus: string // 支付状态
  participantName: string // 参与人姓名
  participantPhone: string // 参与人手机号
  registrationType: string // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
}

// 活动报名状态响应（用于API调用的完整响应）
export interface WxActivityRegistrationStatusResponse {
  data: WxActivityRegistrationResponse
  msg: string
  code: number
}

// 合伙人兑换码报名请求参数
export interface WxPartnerRedemptionCodeRequest {
  activityID: number // 活动ID
  // 合伙人兑换码报名不需要真实的兑换码
}

// 合伙人兑换码报名响应
export interface WxPartnerRedemptionCodeResponse {
  registrationID: number // 报名ID
  verificationCode: string // 核销码
  paymentStatus: string // 支付状态
  participantName: string // 参与人姓名
  participantPhone: string // 参与人手机号
  registrationType: string // 报名方式: paid-付费报名, free-免费报名, code-兑换码报名
}

// 合伙人兑换码报名响应（用于API调用的完整响应）
export interface WxPartnerRedemptionCodeStatusResponse {
  data: WxPartnerRedemptionCodeResponse
  msg: string
  code: number
}