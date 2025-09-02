import { httpPost } from '@/http/http'

// 微信图片上传响应类型
export interface WxImageUploadResponse {
  code: number
  data: {
    file: {
      id: number
      createdAt: string
      updatedAt: string
      deletedAt: string | null
      name: string
      classId: number
      url: string
      tag: string
      key: string
    }
  }
  msg: string
}

/**
 * 微信小程序上传图片
 * @param file - 要上传的文件
 * @param classId - 分类ID（可选）
 * @returns 上传结果
 */
export function wxUploadImage(file: File, classId?: number) {
  const formData = new FormData()
  formData.append('file', file)
  if (classId !== undefined) {
    formData.append('classId', classId.toString())
  }

  return httpPost<WxImageUploadResponse>('/api/wx/uploadImage', formData, undefined, {
    'Content-Type': 'multipart/form-data',
  })
}
