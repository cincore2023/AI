<script setup lang="ts">
import { CourseStore } from '@/store/course'
import CourseCard from './CourseCard.vue'

const { hotCourse } = CourseStore()
</script>

<template>
  <view class="recommended-section">
    <view class="section-header mb-4">
      <text class="section-title text-lg font-bold">推荐</text>
    </view>

    <scroll-view class="courses-scroll" :scroll-x="true" :show-scrollbar="false" enhanced="true">
      <view class="courses-container flex">
        <view v-for="course in hotCourse" :key="course.id" class="course-item mr-4">
          <CourseCard :course="course" class="course-card-shadow"/>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.recommended-section {
  margin-bottom: 40rpx;
}

.section-title {
  font-size: 40rpx;
  color: var(--text-primary);
}

.courses-scroll {
  // 确保内容可以滚动
  white-space: nowrap;
}

.courses-container {
  display: flex;
  align-items: stretch;
}

.course-item {
  flex-shrink: 0;
  width: 240px; // 每个子项占240px
  min-width: 240px;
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
