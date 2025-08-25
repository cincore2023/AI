/**
 * 用户信息
 */
export interface IUserInfoVo {
  id: number
  username: string
  avatar: string
  token: string
}

/**
 * 登录返回的信息
 */
export interface IUserLogin {
  id: string
  username: string
  token: string
}

/**
 * 获取验证码
 */
export interface ICaptcha {
  captchaEnabled: boolean
  uuid: string
  image: string
}
/**
 * 上传成功的信息
 */
export interface IUploadSuccessInfo {
  fileId: number
  originalName: string
  fileName: string
  storagePath: string
  fileHash: string
  fileType: string
  fileBusinessType: string
  fileSize: number
}
/**
 * 更新用户信息
 */
export interface IUpdateInfo {
  id: number
  name: string
  sex: string
}
/**
 * 更新用户信息
 */
export interface IUpdatePassword {
  id: number
  oldPassword: string
  newPassword: string
  confirmPassword: string
}

/**
 * 微信用户信息
 */
export interface IWechatUser {
  id: number
  avatar?: string
  openId?: string
  nickname?: string
  phone_number?: string
  salesperson?: number
  relationshipChannel?: number
  benefitLevel?: number
  withdrawableIncome?: number
  cumulativeIncome?: number
  membershipExpiryDate?: string
  membershipRedemptionCode?: string
  activityRedemptionCode?: string
  isActive?: boolean
  createdAt?: string
  updatedAt?: string
}

/**
 * 绑定销售员响应数据
 */
export interface IWxBindSalespersonResponse {
  salesperson: IWxSalespersonInfo
  bindingSuccess: boolean
  message: string
}

/**
 * 销售员信息
 */
export interface IWxSalespersonInfo {
  id: number
  nickname: string
  phoneNumber: string
}
