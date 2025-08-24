<!-- 讲师简介组件 -->
<script setup lang="ts">
import type { ITeacherDetailItem } from '@/api/types/teacher'

// 定义组件Props，提供默认值
interface Props {
  instructor: ITeacherDetailItem
}

withDefaults(defineProps<Props>(), {})
</script>

<template>
  <view class="instructor-bio">
    <!-- 讲师头像和基本信息 -->
    <view class="bio-header">
      <view class="avatar-section">
        <image :src="instructor.avatar" class="bio-avatar" mode="aspectFill"/>
      </view>
      <view class="basic-info">
        <text class="bio-name">{{ instructor.name }}</text>
        <text class="bio-title">{{ instructor.description }}</text>
      </view>
    </view>

    <!-- 讲师简介 -->
    <view class="bio-section">
      <view class="section-header">
        <text class="section-title">个人简介</text>
      </view>
      <view class="bio-content">
        <view v-html="instructor?.introduction" />
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.instructor-bio {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-lg);
}

.bio-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  padding: var(--spacing-md);
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
}

.avatar-section {
  flex-shrink: 0;
}

.bio-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  border: 2rpx solid var(--border-primary);
}

.basic-info {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-xs);
}

.bio-name {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.bio-title {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.section-header {
  margin-bottom: var(--spacing-sm);
}

.section-title {
  font-size: 28rpx;
  font-weight: 600;
  color: var(--text-primary);
  position: relative;
  padding-left: var(--spacing-sm);

  &::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 6rpx;
    height: 24rpx;
    background-color: var(--primary-color);
    border-radius: 3rpx;
  }
}

.bio-section,
.experience-section,
.specialties-section {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  box-shadow: var(--shadow-sm);
}

.bio-content,
.experience-content {
  line-height: 1.6;
}

.bio-text,
.experience-text {
  font-size: 28rpx;
  color: var(--text-secondary);
  line-height: 1.6;
}

.specialties-content {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.specialties-grid {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-sm);
}

.specialty-tag {
  cursor: pointer;
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.95);
  }
}

.more-specialties {
  font-size: 24rpx;
  color: var(--text-tertiary);
  font-style: italic;
}

.contact-section {
  display: flex;
  justify-content: center;
  padding: var(--spacing-md) 0;
}

.contact-button {
  width: 100%;
  max-width: 400rpx;
  border-radius: var(--radius-lg);
  font-weight: 600;

  // 点击效果
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.98);
  }
}
</style>
