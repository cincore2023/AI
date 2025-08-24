import type { IBannerItem } from '@/api/types/banner'
import type { ITeacherItem } from '@/api/types/teacher'

import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getBanners } from '@/api/banner'
import { getTeachers } from '@/api/teacher'

export const AppStore = defineStore(
  'app',
  () => {
    // 定义用户信息
    const banner = ref<IBannerItem[]>([])
    const teacher = ref<ITeacherItem[]>([])

    /**
     * Banner
     */
    const getBannerList = async () => {
      const { data } = await getBanners()
      // 存储到本地
      uni.setStorageSync('BannerList', data.banners)
      banner.value = data.banners
    }

    /**
     * 教师
     */
    const getTeacherList = async () => {
      const { data } = await getTeachers()
      uni.setStorageSync('TeacherList', data.teachers)
      teacher.value = data.teachers
    }

    return {
      banner,
      teacher,
      getBannerList,
      getTeacherList,
    }
  },
  {
    persist: true,
  },
)
