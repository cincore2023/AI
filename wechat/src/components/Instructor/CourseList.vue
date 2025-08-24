<!-- 课程列表组件 -->
<script setup lang="ts">
import type { WxCourseItem } from '@/api/types/course'
import CourseCard from '@/components/Home/CourseCard.vue'

// 定义组件Props，提供默认值
interface Props {
  courses?: WxCourseItem[] | undefined
}

const props = defineProps<Props>()

// 计算属性
const hasCourses = computed(() => props.courses && props.courses.length > 0)
</script>

<template>
  <view class="course-list-container">
    <!-- 课程列表 -->
    <view v-if="hasCourses">
      <view v-for="course in courses" :key="course.id" class="course-item">
        <!-- 使用现有的CourseCard组件 -->
        <CourseCard :course="course"/>
      </view>
    </view>

    <!-- 空状态 -->
    <sar-empty v-else/>
  </view>
</template>

<style lang="scss" scoped>
.course-list-container {
  width: 100%;
}

.course-item {
  // 点击效果
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.98);
  }
}
</style>
