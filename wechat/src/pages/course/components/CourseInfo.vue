<script setup lang="ts">
import type { WxCourseDetailItem } from '@/api/types/course'
import { useUserStore } from '@/store/user'

defineProps<Props>()

const { isMember } = useUserStore()

interface Props {
  detail: WxCourseDetailItem
}
</script>

<template>
  <view class="py-4 pb-0">
    <!-- 价格信息 -->
    <view class="price-section flex items-center justify-between">
      <view class="price-info">
        <text class="price-label">价格:</text>
        <text class="price-value">¥{{ detail?.price }}</text>
        <text class="member-free">会员免费</text>
      </view>
      <view class="course-stats">
        已学习: {{ detail?.apprenticeCount || 0 }}人
      </view>
    </view>

    <view class="course-title">
      {{ detail?.courseTitle }}
    </view>

    <!-- 会员状态提示 -->
    <view v-if="!isMember" class="member-notice member-notice-non">
      <view class="notice-content">
        <text class="notice-icon">☆</text>
        <text class="notice-text">成为会员可免费观看该课程</text>
        <text class="notice-arrow">→</text>
      </view>
    </view>

    <view v-else class="member-notice member-notice-member">
      <view class="notice-content">
        <text class="notice-icon">☆</text>
        <text class="notice-text">您是会员，可免费观看</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.course-title {
  font-size: 36rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
  line-height: 1.4;
}

.course-stats {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-section {
  margin-bottom: var(--spacing-md);
}

.price-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.price-label {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-value {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--error-color);
}

.member-free {
  font-size: 24rpx;
  color: var(--success-color);
  background: rgba(82, 196, 26, 0.1);
  padding: 4rpx 12rpx;
  border-radius: var(--radius-sm);
}

.member-notice {
  padding: var(--spacing-md);
  border-radius: var(--radius-md);
  margin-bottom: var(--spacing-md);

  &.member-notice-non {
    background: rgba(250, 173, 20, 0.1);
    border: 1px solid rgba(250, 173, 20, 0.3);
  }

  &.member-notice-member {
    background: rgba(82, 196, 26, 0.1);
    border: 1px solid rgba(82, 196, 26, 0.3);
  }
}

.notice-content {
  display: flex;
  align-items: center;
}

.notice-icon {
  font-size: 32rpx;
  margin-right: var(--spacing-sm);
  color: var(--warning-color);
}

.member-notice-member .notice-icon {
  color: var(--success-color);
}

.notice-text {
  flex: 1;
  font-size: 26rpx;
  color: var(--text-primary);
}

.notice-arrow {
  font-size: 32rpx;
  color: var(--text-secondary);
}
</style>
