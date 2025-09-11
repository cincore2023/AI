<!-- 微信小程序登录页面 -->
<route lang="jsonc">
{
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "登录"
}
}
</route>

<script lang="ts" setup>
import { useUserStore } from '@/store/user'
import { toast } from '@/utils/toast'

const userStore = useUserStore()

// 登录状态
const isLogging = ref(false)

// 页面挂载时检查登录状态
onMounted(() => {
  // 如果已经登录，跳转到首页
  if (userStore.isLoggedIn && userStore.token) {
    uni.switchTab({
      url: '/pages/index/index'
    })
  }
})

/**
 * 微信登录
 */
async function handleWxLogin() {
  if (isLogging.value) return

  try {
    isLogging.value = true
    
    console.log('开始微信登录流程')
    
    // 调用微信登录
    const result = await userStore.wxLogin()
    console.log('微信登录结果:', result)
    
    toast.success('登录成功')
    
    // 登录成功后跳转到首页
    uni.switchTab({ url: '/pages/index/index' })
  } catch (error: any) {
    console.error('微信登录失败:', error)
    
    let errorMessage = '登录失败，请重试'
    
    if (error && error.message) {
      errorMessage = error.message
    } else if (error && error.data && error.data.msg) {
      errorMessage = error.data.msg
    } else if (typeof error === 'string') {
      errorMessage = error
    }
    
    toast.error(errorMessage)
  } finally {
    isLogging.value = false
    uni.hideLoading()
  }
}

/**
 * 跳转到调试页面
 */
function goToDebug() {
  uni.navigateTo({
    url: '/pages/debug/debug'
  })
}
</script>

<template>
  <view class="login-container">
    <!-- 状态栏占位 -->
    <view class="status-bar"></view>

    <!-- 背景装饰 -->
    <view class="background-decoration">
      <view class="circle circle-1"></view>
      <view class="circle circle-2"></view>
      <view class="circle circle-3"></view>
    </view>

    <!-- 登录内容 -->
    <view class="login-content">
      <!-- Logo和标题 -->
      <view class="logo-section">
        <text class="app-name">欢迎使用</text>
        <text class="app-description">请使用微信登录以获得更好的体验</text>
      </view>

      <!-- 登录按钮区域 -->
      <view class="login-actions">
        <!-- 微信登录按钮 -->
        <button class="wx-login-btn" :class="{ 'loading': isLogging }" :disabled="isLogging" @click="handleWxLogin">
          <text class="btn-text">
            {{ isLogging ? '登录中...' : '微信登录' }}
          </text>
        </button>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.login-container {
  min-height: 100vh;
  position: relative;
  //background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  overflow: hidden;
}

.status-bar {
  height: var(--status-bar-height);
}

.background-decoration {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;

  .circle {
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.1);

    &.circle-1 {
      width: 200rpx;
      height: 200rpx;
      top: 20%;
      right: -100rpx;
      animation: float 6s ease-in-out infinite;
    }

    &.circle-2 {
      width: 150rpx;
      height: 150rpx;
      top: 60%;
      left: -75rpx;
      animation: float 8s ease-in-out infinite reverse;
    }

    &.circle-3 {
      width: 100rpx;
      height: 100rpx;
      top: 40%;
      right: 40rpx;
      animation: float 10s ease-in-out infinite;
    }
  }
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-20px);
  }
}

.login-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: calc(100vh - var(--status-bar-height));
  padding: 60rpx 40rpx;
  position: relative;
  z-index: 1;
}

.logo-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 120rpx;

  .logo {
    width: 160rpx;
    height: 160rpx;
    margin-bottom: 40rpx;
    border-radius: 20rpx;
    box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.1);
  }

  .app-name {
    font-size: 48rpx;
    font-weight: bold;
    margin-bottom: 20rpx;
    text-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);
  }

  .app-description {
    font-size: 28rpx;
    text-align: center;
    line-height: 1.5;
  }
}

.login-actions {
  width: 100%;
  margin-bottom: 80rpx;

  .wx-login-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 96rpx;
    background: #07c160;
    color: #ffffff;
    border-radius: 48rpx;
    border: none;
    font-size: 32rpx;
    font-weight: 500;
    margin-bottom: 24rpx;
    box-shadow: 0 8rpx 24rpx rgba(7, 193, 96, 0.3);
    transition: all 0.3s ease;

    &:active {
      transform: translateY(2rpx);
      box-shadow: 0 4rpx 12rpx rgba(7, 193, 96, 0.3);
    }

    &.loading {
      background: #999999;
      box-shadow: 0 8rpx 24rpx rgba(153, 153, 153, 0.3);
    }

    .wx-icon {
      width: 40rpx;
      height: 40rpx;
      margin-right: 16rpx;
    }

    .btn-text {
      color: inherit;
      font-size: inherit;
    }
  }
  
  .debug-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 80rpx;
    background: rgba(255, 255, 255, 0.15);
    color: rgba(255, 255, 255, 0.8);
    border-radius: 40rpx;
    border: 2rpx solid rgba(255, 255, 255, 0.3);
    font-size: 28rpx;
    font-weight: 400;
    margin-bottom: 24rpx;
    transition: all 0.3s ease;

    &:active {
      background: rgba(255, 255, 255, 0.25);
      transform: translateY(1rpx);
    }

    .btn-text {
      color: inherit;
      font-size: inherit;
    }
  }

  .guest-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 96rpx;
    background: rgba(255, 255, 255, 0.2);
    color: #ffffff;
    border-radius: 48rpx;
    border: 2rpx solid rgba(255, 255, 255, 0.3);
    font-size: 32rpx;
    font-weight: 400;
    transition: all 0.3s ease;

    &:active {
      background: rgba(255, 255, 255, 0.3);
    }

    .btn-text {
      color: inherit;
      font-size: inherit;
    }
  }
}

.agreement-section {
  width: 100%;

  .agreement-checkbox {
    display: flex;
    align-items: flex-start;

    .checkbox {
      width: 32rpx;
      height: 32rpx;
      border: 2rpx solid rgba(255, 255, 255, 0.6);
      border-radius: 6rpx;
      margin-right: 16rpx;
      margin-top: 4rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      background: transparent;
      transition: all 0.3s ease;

      &.checked {
        background: #07c160;
        border-color: #07c160;

        .checkbox-icon {
          color: #ffffff;
          font-size: 20rpx;
          font-weight: bold;
        }
      }
    }

    .agreement-text {
      flex: 1;
      font-size: 24rpx;
      color: rgba(255, 255, 255, 0.8);
      line-height: 1.6;

      .link {
        color: #ffffff;
        text-decoration: underline;
        font-weight: 500;
      }
    }
  }
}
</style>