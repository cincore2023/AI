import type { WxCourseItem } from '@/api/types/course'
import { defineStore } from 'pinia'
import { getWxCourseList } from '@/api/course'

export const CourseStore = defineStore(
  'course',
  () => {
    const hotCourse = ref<WxCourseItem[]>([])
    const exquisiteCourse = ref<WxCourseItem[]>([])

    const getHotCourse = async () => {
      const { data } = await getWxCourseList({ hot: true })
      hotCourse.value = data.courses
    }

    const getExquisiteCourse = async () => {
      const { data } = await getWxCourseList({ exquisite: true })
      exquisiteCourse.value = data.courses
    }

    return {
      hotCourse,
      exquisiteCourse,
      getHotCourse,
      getExquisiteCourse,
    }
  },
  {
    persist: true,
  },
)
