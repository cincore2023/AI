import type { IBannerResponse } from './types/banner'
import { http } from '@/http/http'

/**
 * 获取轮播图列表
 * @returns Promise<IBannerResponse> 轮播图数据
 */
export function getBanners() {
  return http.get<IBannerResponse>('/api/wx/Banners')
}
