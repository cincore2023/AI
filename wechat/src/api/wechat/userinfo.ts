import { http } from '@/http/http'

/**
 * 微信用户信息相关API
 */

// 解密微信手机号请求参数
export interface IWxDecryptPhoneRequest {
  code: string
}

// 更新用户信息请求参数
export interface IWxUpdateUserInfoRequest {
  nickname?: string
  avatar?: string
}

// 解密微信手机号响应
export interface IWxDecryptPhoneResponse {
  phoneNumber: string
}

// 解密微信手机号
export function wxDecryptPhone(data: IWxDecryptPhoneRequest) {
  return http.post<IWxDecryptPhoneResponse>('/api/wx/DecryptPhone', data)
}

// 更新用户信息
export function wxUpdateUserInfo(data: IWxUpdateUserInfoRequest) {
  return http.post('/api/wx/UpdateUserInfo', data)
}

// 上传用户头像
export function wxUploadAvatar(file: File) {
  const formData = new FormData()
  formData.append('file', file)
  return http.post<string>('/api/wx/UploadAvatar', formData, {}, {
    'Content-Type': 'multipart/form-data',
  })
}