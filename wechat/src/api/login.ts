import type {
  IWechatUser,
  IWxBindSalespersonResponse,
} from './types/login'
import { http } from '@/http/http'

/**
 * 登录表单
 */
export interface ILoginForm {
  username: string
  password: string
  code: string
  uuid: string
}

/**
 * 获取微信登录凭证
 * @returns Promise 包含微信登录凭证(code)
 */
export function getWxCode() {
  return new Promise<UniApp.LoginRes>((resolve, reject) => {
    uni.login({
      provider: 'weixin',
      success: res => resolve(res),
      fail: err => reject(new Error(err)),
    })
  })
}

/**
 * 微信登录
 * @returns Promise 包含登录结果
 * @param data
 */
export function wxLogin(data: { code: string }) {
  return http.post<{
    isNewUser: boolean
    user: IWechatUser
    token: string
    expiresAt: number
  }>('/api/wx/Login', data)
}

/**
 * 绑定销售员
 * @returns Promise 包含绑定结果
 * @param phone
 */
export function bindSalesperson(phone: string) {
  return http.post<IWxBindSalespersonResponse>('/api/wx/BindSalesperson', { SalespersonPhone: phone })
}
