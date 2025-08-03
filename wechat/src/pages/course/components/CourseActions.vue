<script setup lang="ts">

interface Props {
  isMember: boolean
}

interface Emits {
  (e: 'action'): void
}

defineProps<Props>()

defineEmits<Emits>()

const systemInfo = uni.getWindowInfo()

const BottomStyle = computed(() => ({
  paddingBottom: `${systemInfo.windowHeight - systemInfo.safeArea.bottom}px` || '0px',
  paddingTop: '20rpx',
}))

</script>

<template>
  <view class="bottom-actions" :style="BottomStyle">
    <view class="action-buttons">
      <sar-button type="text">
        <view class="action-btn">
          <view class="action-icon">
            🏠
          </view>
          <view class="action-text">
            首页
          </view>
        </view>
      </sar-button>
      <sar-button type="text">
        <view class="action-btn">
          <view class="action-icon">
            ⭐
          </view>
          <view class="action-text">
            收藏
          </view>
        </view>
      </sar-button>
      <sar-button type="text">
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
    <sar-button class="main-action-btn" round inline theme="secondary" @click="$emit('action')">
      {{ isMember ? '您是会员，可免费观看' : '开通会员，免费看' }}
    </sar-button>
  </view>
</template>

<style lang="scss" scoped>
.bottom-actions {
  background-color: var(--bg-primary);
  border-top: 1px solid var(--border-primary);
  padding-top: 20rpx;
  display: flex;
  align-items: center;
  gap: 26px;
}

.action-buttons {
  display: grid;
  flex: 1;
  grid-template-columns: repeat(3, 1fr);
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
  width: 40%;
  font-size: 26rpx;
  font-weight: bold;
  border: none;
  color: var(--text-primary);
  background-color: var(--bg-inverse);
}
</style>
