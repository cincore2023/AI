<script setup lang="ts">
// 定义 props
interface Props {
  title?: string
  showBack?: boolean
  showRight?: boolean
}

withDefaults(defineProps<Props>(), {
  title: '',
  showBack: false,
  showRight: true,
})

// 响应式数据
const safeAreaInsets = ref<any>(null)

// 获取屏幕边界到安全区域距离
const systemInfo = uni.getWindowInfo()

safeAreaInsets.value = systemInfo.safeArea
  ? {
      top: systemInfo.safeArea.top,
      right: systemInfo.windowWidth - systemInfo.safeArea.right,
      bottom: systemInfo.windowHeight - systemInfo.safeArea.bottom,
      left: systemInfo.safeArea.left,
    }
  : null

const headerStyle = computed(() => ({
  paddingTop: `${safeAreaInsets.value?.top}px` || '0px',
}))

function handleBack() {
  try {
    uni.navigateBack()
  } catch (e) {
    uni.switchTab({ url: '/pages/index/index' })
  }
}
</script>

<template>
  <view class="header" :style="headerStyle">
    <!-- 头部内容 -->
    <view class="header-content">
      <!-- 左侧：返回按钮或用户信息 -->
      <view class="left-section">
        <view v-if="showBack" class="back-btn" @click="handleBack">
          <text class="back-icon">←</text>
        </view>
      </view>

      <!-- 中间：标题 -->
      <view class="center-section">
        <text class="header-title">{{ title }}</text>
      </view>
    </view>

    <!-- 底部插槽 -->
    <view class="header-bottom">
      <slot name="bottom" />
    </view>
  </view>
</template>

<style lang="scss" scoped>
.header {
  position: relative;
  z-index: 100;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 0 20rpx;
  min-height: 80rpx;
}

.left-section {
  flex: 1;
  display: flex;
  align-items: center;
  position: absolute;
  left: 0;
}

.back-btn {
  width: 60rpx;
  height: 60rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.2);
  border-radius: var(--radius-md);
  backdrop-filter: blur(10rpx);
}

.back-icon {
  font-size: 32rpx;
  color: var(--text-primary);
  font-weight: bold;
}

.center-section {
  flex: 2;
  display: flex;
  justify-content: center;
  align-items: center;
}

.header-title {
  font-size: 36rpx;
  font-weight: bold;
  color: var(--text-primary);
  text-align: center;
}

.header-bottom {
  padding-bottom: 12rpx;
}
</style>
