<script setup lang="ts">
import type { WxCourseItem } from '@/api/types/course'

const props = defineProps<{ course: WxCourseItem }>()

// TODO: 计算学习人数
const apprenticeCount = computed(() => {
  return (props.course.apprenticeCount || 0)
})

// 课程类型显示
function formatType(type: string) {
  return type === 'img' ? '图文' : '视频'
}

function handleCourseClick() {
  uni.navigateTo({
    url: `/pages/course/detail?id=${props.course.id}`,
  })
}
</script>

<template>
  <view class="course-card h-full overflow-hidden rounded-lg bg-[var(--bg-primary)]" @click="handleCourseClick">
    <!-- 课程图片 -->
    <view class="course-image relative">
      <image :src="course.coverImage" class="h-32 w-full object-cover"/>

      <view class="course-tag absolute bottom-2 right-2 rounded bg-gray bg-opacity-60 px-2 py-1 text-xs text-white">
        {{ formatType(course.type) }}
      </view>
    </view>

    <!-- 课程信息 -->
    <view class="course-info flex-1 p-3">
      <!-- 课程标题 -->
      <text class="course-title line-clamp-2 text-sm font-medium">{{ course.courseTitle }}</text>

      <!-- 学习人数和价格 -->
      <view class="course-meta mt-2 flex items-center justify-between">
        <text class="learners text-xs">{{ apprenticeCount }}人学习</text>
        <view class="price-wrapper flex items-center gap-1">
          <text class="price text-sm font-bold">
            {{ course.price }}
          </text>
          <text class="original-price text-xs text-gray line-through">¥{{ course.originalPrice }}</text>
        </view>
      </view>

      <!-- 上架状态 -->
      <view v-if="!course.onSale" class="status-badge mt-2">
        <text class="off-sale-badge">未上架</text>
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
  backdrop-filter: blur(4rpx);
}

.course-title {
  font-size: 28rpx;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
  color: var(--text-primary);
}

.course-meta {
  font-size: 24rpx;
}

.learners {
  color: var(--text-tertiary);
}

.price {
  font-weight: 600;
  color: var(--error-color);
}
</style>
