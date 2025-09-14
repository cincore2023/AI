<script setup lang="ts">
interface Props {
  isMember: boolean
  isFavorite?: boolean
}

interface Emits {
  (e: 'action'): void
  (e: 'toggleFavorite'): void
}

defineProps<Props>()

defineEmits<Emits>()

// 回到首页
function goHome() {
  uni.switchTab({
    url: '/pages/index/index',
  })
}

// 分享功能
function shareCourse() {
  // #ifdef MP-WEIXIN
  uni.showShareMenu({
    withShareTicket: true,
    menus: ['shareAppMessage', 'shareTimeline'],
  })
  // #endif

  // #ifndef MP-WEIXIN
  uni.showToast({
    title: '分享功能仅在微信小程序中可用',
    icon: 'none',
  })
  // #endif
}

const systemInfo = uni.getWindowInfo()

const BottomStyle = computed(() => ({
  paddingBottom: `${systemInfo.windowHeight - systemInfo.safeArea.bottom + 5}px` || '0px',
  paddingTop: '20rpx',
}))
</script>

<template>
  <view class="bottom-actions" :style="BottomStyle">
    <view class="action-buttons">
      <sar-button type="text" @click="goHome">
        <view class="action-btn">
          <view class="action-icon">
            🏠
          </view>
          <view class="action-text">
            首页
          </view>
        </view>
      </sar-button>
      <sar-button type="text" @click="$emit('toggleFavorite')">
        <view class="action-btn">
          <view class="action-icon">
            {{ isFavorite ? '⭐' : '☆' }}
          </view>
          <view class="action-text">
            {{ isFavorite ? '已收藏' : '收藏' }}
          </view>
        </view>
      </sar-button>
      <sar-button type="text" open-type="share" @click="shareCourse">
        <view class="action-btn">
          <view class="action-icon">
            📤
          </view>
          <view class="action-text">
            分享
          </view>
        </view>
      </sar-button>
    </view>
    <sar-button class="main-action-btn" round inline theme="primary" @click="$emit('action')">
      {{ isMember ? '您是会员，可免费观看' : '开通会员，免费看' }}
    </sar-button>
  </view>
</template>

<style lang="scss" scoped>
.bottom-actions {
  background: var(--bg-primary);
  display: flex;
  align-items: center;
  gap: 26px;
  padding: 32rpx;
  box-shadow: var(--shadow-lg);
}

.action-buttons {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8rpx;
}

.action-btn {
  padding: var(--spacing-sm) 0;
  text-align: center;
  color: var(--bg-inverse);
}

.action-icon {
  font-size: 32rpx;
  margin-bottom: var(--spacing-xs);
}

.action-text {
  font-size: 22rpx;
}

.main-action-btn {
  flex: 1;
  font-size: 26rpx;
  font-weight: bold;
  border: none;
  color: var(--text-primary);
  background-color: var(--bg-inverse);
}
</style>
