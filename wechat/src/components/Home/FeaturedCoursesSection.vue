<script setup lang="ts">
import { CourseStore } from '@/store/course'
import CourseCard from './CourseCard.vue'

const { exquisiteCourse } = CourseStore()
</script>

<template>
  <view class="featured-section">
    <view class="section-header mb-4">
      <text class="section-title text-lg font-bold">精选课程</text>
    </view>

    <view class="courses-grid grid grid-cols-2 gap-3">
      <CourseCard v-for="course in exquisiteCourse" :key="course.id" :course="course" class="course-card-shadow"/>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.featured-section {
  margin-bottom: 40rpx;
}

.section-title {
  font-size: 40rpx;
  color: var(--text-primary);
}

.course-card-shadow {
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;

  &:active {
    transform: translateY(-2rpx);
    box-shadow: var(--shadow-lg);
  }
}
</style>
