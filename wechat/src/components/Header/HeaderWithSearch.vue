<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'

// 响应式数据
const searchText = ref('')
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

function handleSearch() {
  if (!searchText.value.trim()) {
    uni.showToast({
      title: '请输入搜索内容',
      icon: 'none',
    })
    return
  }

  console.log('搜索内容:', searchText.value)
  // 这里可以添加搜索逻辑
  uni.showToast({
    title: '搜索功能开发中',
    icon: 'none',
  })
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

    <!-- 头部内容 -->
    <view class="header-content">
      <view class="left-section" @click="handleCompleteInfo">
        <view class="greeting">
          <text class="greeting-text">{{ greeting }}</text>
          <text class="user-name">用户{{ userId }}</text>
        </view>
        <text class="complete-hint">点击完善您的信息</text>
      </view>
    </view>

    <!-- 搜索框 -->
    <view class="search-section">
      <view class="search-bar">
        <view class="search-input-wrapper">
          <text class="search-icon">🔍</text>
          <input
            v-model="searchText"
            class="search-input"
            placeholder="搜课程名称/智能体"
            @confirm="handleSearch"
          >
        </view>
        <view class="search-divider" />
        <text class="search-btn" @click="handleSearch">搜索</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.header {
  position: relative;
  z-index: 100;
}

.status-bar {
  //width: 100%;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding-top: 20rpx;
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
  color: #333333;
  margin-right: 10rpx;
}

.user-name {
  font-size: 32rpx;
  font-weight: bold;
  color: #333333;
}

.complete-hint {
  font-size: 24rpx;
  color: #666666;
  opacity: 0.8;
}

.search-section {
  padding-top: 20rpx;
  padding-bottom: 12rpx;
}

.search-bar {
  display: flex;
  align-items: center;
  background: var(--bg-primary);
  border-radius: var(--radius-lg);
  padding: 20rpx;
  border: 1rpx solid var(--border-primary);
  box-shadow: var(--shadow-sm);
}

.search-input-wrapper {
  flex: 1;
  display: flex;
  align-items: center;
}

.search-icon {
  font-size: 28rpx;
  color: var(--text-tertiary);
  margin-right: 16rpx;
}

.search-input {
  flex: 1;
  font-size: 28rpx;
  color: var(--text-primary);

  &::placeholder {
    color: var(--text-tertiary);
  }
}

.search-divider {
  width: 1rpx;
  height: 40rpx;
  background: var(--border-primary);
  margin: 0 20rpx;
}

.search-btn {
  font-size: 28rpx;
  color: var(--text-secondary);
  padding: 10rpx 20rpx;
}
</style>
