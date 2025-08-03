<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'

// 响应式数据
const activeToggle = ref('target')
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

// 计算属性
const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 12)
    return '上午好'
  if (hour < 18)
    return '下午好'
  return '晚上好'
})

const userId = ref('0001')

const headerStyle = computed(() => ({
  paddingTop: `${safeAreaInsets.value?.top}px` || '0px',
}))

// 方法
function setActiveToggle(type: 'dots' | 'target') {
  activeToggle.value = type
}

function handleCompleteInfo() {
  // #ifdef MP-WEIXIN
  uni.getUserProfile({
    desc: '用于完善用户信息',
    success: (res) => {
      console.log('获取用户信息成功', res)
      // 这里可以调用后端API保存用户信息
      uni.showToast({
        title: '信息获取成功',
        icon: 'success',
      })
    },
    fail: (err) => {
      console.log('获取用户信息失败', err)
      uni.showToast({
        title: '获取信息失败',
        icon: 'error',
      })
    },
  })
  // #endif

  // #ifndef MP-WEIXIN
  uni.showToast({
    title: '请在微信小程序中使用此功能',
    icon: 'none',
  })
  // #endif
}

onMounted(() => {
  // 获取系统信息
  uni.getSystemInfo({
    success: (res) => {
      console.log('系统信息:', res)
    },
  })
})
</script>

<template>
  <view class="header" :style="headerStyle">
    <!-- 状态栏占位 -->
    <view class="status-bar" :style="{ height: `${safeAreaInsets?.top}px` }" />

    <!-- 头部内容 -->
    <view class="header-content">
      <!-- 左侧：完善信息 -->
      <view class="left-section" @click="handleCompleteInfo">
        <view class="greeting">
          <text class="greeting-text">{{ greeting }}</text>
          <text class="user-name">用户{{ userId }}</text>
        </view>
        <text class="complete-hint">点击完善您的信息</text>
      </view>

      <!-- 右侧：切换按钮 -->
      <view class="right-section">
        <view class="toggle-group">
          <view
            class="toggle-item"
            :class="{ active: activeToggle === 'dots' }"
            @click="setActiveToggle('dots')"
          >
            <text class="toggle-icon">⋯</text>
          </view>
          <view
            class="toggle-item"
            :class="{ active: activeToggle === 'target' }"
            @click="setActiveToggle('target')"
          >
            <text class="toggle-icon">🎯</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.header {
  background: var(--gradient-header);
  padding: 0 20rpx;
  position: relative;
  z-index: 100;
}

.status-bar {
  width: 100%;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 20rpx 0 30rpx;
}

.left-section {
  flex: 1;
}

.greeting {
  margin-bottom: 10rpx;
}

.greeting-text {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-inverse);
  margin-right: 10rpx;
}

.user-name {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-inverse);
}

.complete-hint {
  font-size: 24rpx;
  color: var(--text-inverse);
  opacity: 0.8;
}

.right-section {
  display: flex;
  align-items: center;
}

.toggle-group {
  display: flex;
  background: rgba(255, 255, 255, 0.2);
  border-radius: var(--radius-lg);
  padding: 4rpx;
  border: 1rpx solid rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10rpx);
}

.toggle-item {
  width: 60rpx;
  height: 60rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: var(--radius-md);
  transition: all 0.3s ease;

  &.active {
    background: var(--primary-color);

    .toggle-icon {
      color: var(--text-inverse);
    }
  }
}

.toggle-icon {
  font-size: 24rpx;
  color: var(--text-inverse);
}
</style>
