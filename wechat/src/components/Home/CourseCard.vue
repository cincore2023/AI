<script setup lang="ts">
interface Course {
  id: string
  title: string
  image: string
  type: string
  learners: number
  price: string | number
}

defineProps<{
  course: Course
}>()
</script>

<template>
  <view class="course-card h-full overflow-hidden rounded-lg bg-[var(--bg-primary)]" @click="$emit('click', course)">
    <!-- 课程图片 -->
    <view class="course-image relative">
      <image :src="course.image" class="h-32 w-full object-cover" />
      <!-- 课程类型标签 -->
      <view class="course-tag absolute bottom-2 right-2 rounded bg-white bg-opacity-90 px-2 py-1 text-xs">
        {{ course.type }}
      </view>
    </view>

    <!-- 课程信息 -->
    <view class="course-info flex-1 p-3">
      <!-- 课程标题 -->
      <text class="course-title line-clamp-2 text-base font-medium">{{ course.title }}</text>

      <!-- 学习人数和价格 -->
      <view class="course-meta mt-2 flex items-center justify-between">
        <text class="learners text-sm">{{ course.learners }}人学习</text>
        <text class="price text-base font-bold">
          {{ course.price === '免费' ? '免费' : `¥${course.price}` }}
        </text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.course-card {
  display: flex;
  flex-direction: column;
  height: 100%;
  min-width: 0;

  &:active {
    transform: scale(0.98);
  }

  // 在网格布局中的样式
  .courses-grid & {
    height: auto;
  }
}

.course-image {
  position: relative;
}

.course-tag {
  font-size: 24rpx;
  color: #666;
  backdrop-filter: blur(4rpx);
}

.course-title {
  font-size: 32rpx;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  color: var(--text-primary);
}

.course-meta {
  font-size: 28rpx;
}

.learners {
  color: var(--text-tertiary);
}

.price {
  font-weight: 600;
  color: var(--success-color);

  //// 免费课程使用不同颜色
  //&:has-text('free') {
  //  color: var(--success-color);
  //}
}
</style>
