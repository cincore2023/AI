<!-- API调试页面 -->
<route lang="jsonc">
{
  "style": {
    "navigationBarTitleText": "API调试"
  }
}
</route>

<script lang="ts" setup>
import { ref } from 'vue'
import { wxLogin, getWxCode } from '@/api/login'
import { http } from '@/http/http'
import { getEnvBaseUrl } from '@/utils'

const debugInfo = ref<string[]>([])
const isLoading = ref(false)

// 添加调试信息
const addDebugInfo = (info: string) => {
  const timestamp = new Date().toLocaleTimeString()
  debugInfo.value.push(`[${timestamp}] ${info}`)
}

// 清空调试信息
const clearDebugInfo = () => {
  debugInfo.value = []
}

// 测试基础配置
const testBasicConfig = () => {
  addDebugInfo('=== 基础配置测试 ===')
  const baseUrl = getEnvBaseUrl()
  addDebugInfo(`服务器地址: ${baseUrl}`)
  addDebugInfo(`环境变量 VITE_SERVER_BASEURL: ${import.meta.env.VITE_SERVER_BASEURL}`)
  addDebugInfo(`当前平台: ${uni.getSystemInfoSync().platform}`)
}

// 测试网络连接
const testNetworkConnection = async () => {
  addDebugInfo('=== 网络连接测试 ===')
  isLoading.value = true
  
  try {
    const baseUrl = getEnvBaseUrl()
    const testUrl = `${baseUrl}/health`
    
    addDebugInfo(`测试连接: ${testUrl}`)
    
    const response = await http({
      url: '/health',
      method: 'GET',
      timeout: 5000
    })
    
    addDebugInfo(`连接成功: ${JSON.stringify(response)}`)
  } catch (error: any) {
    addDebugInfo(`连接失败: ${error.message || JSON.stringify(error)}`)
  } finally {
    isLoading.value = false
  }
}

// 测试微信Code获取
const testWxCode = async () => {
  addDebugInfo('=== 微信Code获取测试 ===')
  isLoading.value = true
  
  try {
    addDebugInfo('正在获取微信登录code...')
    const codeData = await getWxCode()
    addDebugInfo(`微信Code获取成功: ${JSON.stringify(codeData)}`)
  } catch (error: any) {
    addDebugInfo(`微信Code获取失败: ${error.message || JSON.stringify(error)}`)
  } finally {
    isLoading.value = false
  }
}

// 测试完整微信登录流程
const testWxLoginFlow = async () => {
  addDebugInfo('=== 完整微信登录流程测试 ===')
  isLoading.value = true
  
  try {
    // 步骤1: 获取code
    addDebugInfo('步骤1: 获取微信登录code')
    const codeData = await getWxCode()
    addDebugInfo(`Code获取成功: ${codeData.code}`)
    
    // 步骤2: 调用登录接口
    addDebugInfo('步骤2: 调用微信登录接口')
    addDebugInfo(`请求URL: /api/wxLogin`)
    addDebugInfo(`请求参数: {code: "${codeData.code}"}`)
    
    const loginResult = await wxLogin({ code: codeData.code })
    addDebugInfo(`登录响应: ${JSON.stringify(loginResult, null, 2)}`)
    
    if (loginResult.data && loginResult.data.token) {
      addDebugInfo('✅ 微信登录成功!')
    } else {
      addDebugInfo('❌ 微信登录失败: 响应数据异常')
    }
  } catch (error: any) {
    addDebugInfo(`❌ 微信登录失败: ${error.message || JSON.stringify(error)}`)
    
    // 输出详细错误信息
    if (error.data) {
      addDebugInfo(`错误详情: ${JSON.stringify(error.data)}`)
    }
  } finally {
    isLoading.value = false
  }
}

// 直接测试API接口
const testApiDirect = async () => {
  addDebugInfo('=== 直接API接口测试 ===')
  isLoading.value = true
  
  try {
    addDebugInfo('正在直接调用 /api/wxLogin 接口...')
    
    const response = await http({
      url: '/api/wxLogin',
      method: 'POST',
      data: {
        code: 'test_code_123'
      }
    })
    
    addDebugInfo(`API响应: ${JSON.stringify(response, null, 2)}`)
  } catch (error: any) {
    addDebugInfo(`API调用失败: ${error.message || JSON.stringify(error)}`)
    
    if (error.data) {
      addDebugInfo(`错误详情: ${JSON.stringify(error.data)}`)
    }
  } finally {
    isLoading.value = false
  }
}

// 页面加载时自动测试基础配置
onMounted(() => {
  testBasicConfig()
})
</script>

<template>
  <view class="debug-container">
    <view class="header">
      <text class="title">API调试工具</text>
      <text class="subtitle">用于排查微信登录接口问题</text>
    </view>

    <view class="actions">
      <button class="action-btn" @click="testBasicConfig">测试基础配置</button>
      <button class="action-btn" @click="testNetworkConnection" :disabled="isLoading">测试网络连接</button>
      <button class="action-btn" @click="testWxCode" :disabled="isLoading">测试微信Code</button>
      <button class="action-btn" @click="testApiDirect" :disabled="isLoading">测试API接口</button>
      <button class="action-btn primary" @click="testWxLoginFlow" :disabled="isLoading">测试完整流程</button>
      <button class="action-btn danger" @click="clearDebugInfo">清空日志</button>
    </view>

    <view class="debug-output">
      <view class="output-header">
        <text class="output-title">调试日志</text>
        <text class="output-count">{{ debugInfo.length }} 条</text>
      </view>
      
      <scroll-view class="log-container" scroll-y>
        <view v-if="debugInfo.length === 0" class="empty-log">
          暂无调试信息
        </view>
        <view v-for="(info, index) in debugInfo" :key="index" class="log-item">
          <text class="log-text">{{ info }}</text>
        </view>
      </scroll-view>
    </view>

    <view v-if="isLoading" class="loading-overlay">
      <view class="loading-content">
        <text class="loading-text">正在测试...</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.debug-container {
  min-height: 100vh;
  background-color: #f5f5f5;
  padding: 20rpx;
}

.header {
  background: white;
  padding: 40rpx;
  border-radius: 16rpx;
  margin-bottom: 20rpx;
  text-align: center;

  .title {
    display: block;
    font-size: 36rpx;
    font-weight: bold;
    color: #333;
    margin-bottom: 10rpx;
  }

  .subtitle {
    display: block;
    font-size: 24rpx;
    color: #666;
  }
}

.actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
  margin-bottom: 20rpx;

  .action-btn {
    height: 80rpx;
    background: white;
    color: #333;
    border: 2rpx solid #ddd;
    border-radius: 12rpx;
    font-size: 28rpx;

    &.primary {
      background: #007aff;
      color: white;
      border-color: #007aff;
    }

    &.danger {
      background: #ff3b30;
      color: white;
      border-color: #ff3b30;
    }

    &:disabled {
      opacity: 0.5;
    }
  }
}

.debug-output {
  background: white;
  border-radius: 16rpx;
  height: 600rpx;
  display: flex;
  flex-direction: column;

  .output-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30rpx;
    border-bottom: 2rpx solid #f0f0f0;

    .output-title {
      font-size: 32rpx;
      font-weight: bold;
      color: #333;
    }

    .output-count {
      font-size: 24rpx;
      color: #666;
    }
  }

  .log-container {
    flex: 1;
    padding: 20rpx;

    .empty-log {
      text-align: center;
      padding: 60rpx 0;
      color: #999;
      font-size: 28rpx;
    }

    .log-item {
      margin-bottom: 16rpx;
      padding: 20rpx;
      background: #f8f8f8;
      border-radius: 8rpx;

      .log-text {
        font-size: 24rpx;
        color: #333;
        line-height: 1.4;
        word-break: break-all;
      }
    }
  }
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;

  .loading-content {
    background: white;
    padding: 60rpx;
    border-radius: 16rpx;
    text-align: center;

    .loading-text {
      font-size: 28rpx;
      color: #333;
    }
  }
}
</style>