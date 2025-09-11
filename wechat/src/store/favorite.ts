import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getWxCourseFavoriteStatus, toggleWxCourseFavorite } from '@/api/course'
import type { WxCourseItem } from '@/api/types/course'
import { toast } from '@/utils/toast'

export const useFavoriteStore = defineStore(
  'favorite',
  () => {
    // 收藏的课程列表
    const favoriteCourses = ref<WxCourseItem[]>([])
    
    // 课程收藏状态缓存
    const favoriteStatus = ref<Record<number, boolean>>({})

    // 获取课程收藏状态
    const getCourseFavoriteStatus = async (courseId: number) => {
      try {
        // 先从缓存中获取
        if (favoriteStatus.value[courseId] !== undefined) {
          return favoriteStatus.value[courseId]
        }
        
        // 从服务器获取
        const response = await getWxCourseFavoriteStatus(courseId)
        const isFavorite = response.data.isFavorite
        
        // 更新缓存
        favoriteStatus.value[courseId] = isFavorite
        
        return isFavorite
      } catch (error) {
        console.error('获取课程收藏状态失败:', error)
        return false
      }
    }

    // 切换课程收藏状态
    const toggleCourseFavorite = async (courseId: number) => {
      try {
        const response = await toggleWxCourseFavorite(courseId)
        const isFavorite = response.data.isFavorite
        
        // 更新缓存
        favoriteStatus.value[courseId] = isFavorite
        
        // 显示提示信息
        toast.success(isFavorite ? '收藏成功' : '已取消收藏')
        
        return isFavorite
      } catch (error) {
        console.error('切换课程收藏状态失败:', error)
        toast.error('操作失败')
        return favoriteStatus.value[courseId] || false
      }
    }

    // 批量获取课程收藏状态
    const getBatchCourseFavoriteStatus = async (courseIds: number[]) => {
      const results: Record<number, boolean> = {}
      
      // 并行获取所有课程的收藏状态
      const promises = courseIds.map(async (courseId) => {
        try {
          const isFavorite = await getCourseFavoriteStatus(courseId)
          results[courseId] = isFavorite
        } catch (error) {
          console.error(`获取课程${courseId}收藏状态失败:`, error)
          results[courseId] = false
        }
      })
      
      await Promise.all(promises)
      return results
    }

    // 清除缓存
    const clearCache = () => {
      favoriteStatus.value = {}
    }

    return {
      favoriteCourses,
      favoriteStatus,
      getCourseFavoriteStatus,
      toggleCourseFavorite,
      getBatchCourseFavoriteStatus,
      clearCache
    }
  },
  {
    persist: true,
  },
)