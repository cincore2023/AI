import type { WxCategoryItem, WxCourseItem } from '@/api/types/course'
import { defineStore } from 'pinia'
import { getWxCategoryList, getWxCourseList } from '@/api/course'

export const CourseStore = defineStore(
  'course',
  () => {
    const hotCourse = ref<WxCourseItem[]>([])
    const exquisiteCourse = ref<WxCourseItem[]>([])
    const category = ref<WxCategoryItem[]>([])

    const getHotCourse = async () => {
      const { data } = await getWxCourseList({ hot: true })
      hotCourse.value = data.courses
    }

    const getExquisiteCourse = async () => {
      const { data } = await getWxCourseList({ exquisite: true })
      exquisiteCourse.value = data.courses
    }

    const getCategory = async () => {
      const { data } = await getWxCategoryList()
      category.value = data.categories
    }

    return {
      hotCourse,
      category,
      exquisiteCourse,
      getHotCourse,
      getExquisiteCourse,
      getCategory,
    }
  },
  {
    persist: true,
  },
)
