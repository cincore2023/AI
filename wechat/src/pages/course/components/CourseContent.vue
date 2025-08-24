<script setup lang="ts">
import type { WxCourseDetailItem } from '@/api/types/course'
import { useUserStore } from '@/store/user'

defineProps<Props>()

const { isMember } = useUserStore()

interface Props {
  activeTab: number
  detail: WxCourseDetailItem
}
</script>

<template>
  <view class="tab-content">
    <!-- 预览/详情内容 -->
    <view v-if="activeTab === 0" class="content-section">
      <view v-if="!isMember" class="preview-limit">
        <view v-html="detail?.viewDetails" />
        <view class="limit-subtext">
          开通会员后可查看完整课程内容
        </view>
      </view>
      <view v-else class="content-detail">
        <view class="content-card">
          <view class="card-title">
            课程简介
          </view>
          <view class="card-content">
            <view v-html="detail?.courseDetails" />
          </view>
        </view>
      </view>
    </view>

    <!-- 讲师信息 -->
    <view v-if="activeTab === 1" class="content-section">
      <view class="instructor-info">
        <image class="instructor-avatar" :src="detail.teacherInfo?.avatar" />
        <view class="instructor-details">
          <view class="instructor-name">
            {{ detail.teacherInfo?.name }}
          </view>
          <view class="instructor-title">
            {{ detail.teacherInfo?.description }}
          </view>
        </view>
      </view>
      <view class="instructor-bio">
        <view v-html="detail?.teacherInfo?.introduction" />
      </view>
    </view>

    <!-- 资料下载 -->
    <view v-if="activeTab === 2" class="content-section">
      <view class="material-list">
        <view v-for="(material, index) in []" :key="index" class="material-item">
          <view class="material-info">
            <view class="material-icon">
              📄
            </view>
            <view class="material-details">
              <view class="material-name">
                {{ material.name }}
              </view>
              <view class="material-size">
                {{ material.size }}
              </view>
            </view>
          </view>
          <button class="material-download-btn" :class="[isMember ? 'download-active' : 'download-disabled']" :disabled="!isMember" @click="$emit('download', material)">
            {{ isMember ? '下载' : '会员专享' }}
          </button>
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.tab-content {
  min-height: 400rpx;
}

.preview-limit {
  text-align: center;
  padding: var(--spacing-xl) 0;
}

.limit-text {
  font-size: 26rpx;
  color: var(--text-tertiary);
  margin-bottom: var(--spacing-sm);
}

.limit-subtext {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.content-detail {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.content-card {
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
}

.card-title {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
}

.card-content {
  font-size: 26rpx;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-top: 20rpx;
}

.chapter-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.chapter-item {
  display: flex;
  align-items: center;
  font-size: 26rpx;
  color: var(--text-secondary);
}

.chapter-number {
  width: 48rpx;
  height: 48rpx;
  background: var(--primary-color);
  color: var(--text-inverse);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22rpx;
  margin-right: var(--spacing-md);
}

.chapter-title {
  flex: 1;
}

.chapter-duration {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.instructor-info {
  display: flex;
  align-items: center;
  margin-bottom: var(--spacing-md);
}

.instructor-avatar {
  width: 128rpx;
  height: 128rpx;
  border-radius: 50%;
  margin-right: var(--spacing-md);
}

.instructor-details {
  flex: 1;
}

.instructor-name {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-xs);
}

.instructor-title {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.instructor-bio {
  font-size: 26rpx;
  color: var(--text-secondary);
  line-height: 1.6;
}

.material-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.material-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--spacing-md);
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
}

.material-info {
  display: flex;
  align-items: center;
  flex: 1;
}

.material-icon {
  width: 64rpx;
  height: 64rpx;
  background: var(--primary-color);
  color: var(--text-inverse);
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24rpx;
  margin-right: var(--spacing-md);
}

.material-details {
  flex: 1;
}

.material-name {
  font-size: 26rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-xs);
}

.material-size {
  font-size: 22rpx;
  color: var(--text-tertiary);
}

.material-download-btn {
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--radius-sm);
  font-size: 22rpx;
  border: none;

  &.download-active {
    background: var(--primary-color);
    color: var(--text-inverse);
  }

  &.download-disabled {
    background: var(--text-tertiary);
    color: var(--text-inverse);
  }
}
</style>
