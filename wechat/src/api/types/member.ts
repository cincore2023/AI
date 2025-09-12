/**
 * 会员相关类型定义
 */

// 开通会员响应
export interface IOpenMemberResponse {
  orderNo: string // 订单编号
  amount: number // 支付金额
  timeStamp: string // 时间戳
  nonceStr: string // 随机字符串
  package: string // 订单包
  signType: string // 签名类型
  paySign: string // 支付签名
}
