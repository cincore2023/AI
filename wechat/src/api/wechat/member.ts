import { http } from '@/http/http'

/**
 * 微信会员相关API
 */

// 开通会员响应
export interface IOpenMemberResponse {
  appId: string // 应用ID
  timeStamp: string // 时间戳
  nonceStr: string // 随机字符串
  package: string // 订单包
  signType: string // 签名类型
  paySign: string // 支付签名
  amount: number // 支付金额
  orderNo: string // 订单编号
}

// 开通会员
export function wxOpenMember() {
  return http.post<IOpenMemberResponse>('/api/wx/member/open')
}
