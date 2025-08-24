/**
 * 轮播图项目
 */
export interface IBannerItem {
  id: number
  imageUrl: string
  linkUrl: string
  order: number
  type: string
}

/**
 * 轮播图响应数据
 */
export interface IBannerResponse {
  banners: IBannerItem[]
}
