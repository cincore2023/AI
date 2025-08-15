<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "绑定账号"
}
}
</route>
<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="绑定账号" :show-back="true"/>

    <!-- 绑定/更换微信收款账号 -->
    <view class="section">
      <view class="section-header">
        <text class="section-title">绑定/更换微信收款账号</text>
      </view>

      <view class="bind-button" @click="bindWechat">
        <text class="bind-text">点击绑定/更换</text>
      </view>

      <!-- 当前微信信息 -->
      <view class="current-wechat">
        <view class="section-subtitle">当前微信</view>
        <view class="wechat-info" v-if="isBound">
          <view class="wechat-avatar">
            <image :src="wechatInfo.avatar" class="avatar-img"/>
          </view>
          <view class="wechat-details">
            <text class="wechat-name">{{ wechatInfo.nickname }}</text>
            <text class="wechat-phone">{{ maskedPhone }}</text>
          </view>
        </view>
        <view class="wechat-info" v-else>
          <text class="no-bind-text">暂无请绑定</text>
        </view>
      </view>

      <!-- 手机号 -->
      <view class="phone-section">
        <view class="section-subtitle">手机号</view>
        <text class="phone-text">{{ maskedPhone }}</text>
      </view>

      <!-- 验证码 -->
      <view class="verification-section">
        <view class="section-subtitle">验证码</view>
        <view class="verification-input-group">
          <input
              class="verification-input"
              type="number"
              v-model="verificationCode"
              placeholder="请输入手机验证码"
              maxlength="6"
          />
          <view class="verification-btn" @click="getVerificationCode">
            <text class="btn-text">{{ countdown > 0 ? `${countdown}s` : '获取验证码' }}</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 确认按钮 -->
    <view class="submit-section">
      <button
          class="submit-btn"
          :class="{ disabled: !canSubmit }"
          :disabled="!canSubmit"
          @click="confirmBind"
      >
        确认
      </button>
    </view>
  </view>
</template>

<script lang="ts" setup>
import {ref, computed} from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'

defineOptions({
  name: 'BindAccountPage',
})

// 响应式数据
const verificationCode = ref('')
const countdown = ref(0)
const isBound = ref(false)

// 模拟数据
const maskedPhone = ref('185****0617')
const wechatInfo = ref({
  avatar: '/static/images/default-avatar.png',
  nickname: 'Dil'
})

// 计算属性
const canSubmit = computed(() => {
  return verificationCode.value && verificationCode.value.length === 6
})

// 方法
const bindWechat = () => {
  // 调用微信授权
  uni.getUserProfile({
    desc: '用于完善用户资料',
    success: (res) => {
      console.log('微信授权成功', res)
      isBound.value = true
      wechatInfo.value = {
        avatar: res.userInfo.avatarUrl || '/static/images/default-avatar.png',
        nickname: res.userInfo.nickName || '微信用户'
      }
      uni.showToast({
        title: '微信绑定成功',
        icon: 'success'
      })
    },
    fail: (err) => {
      console.log('微信授权失败', err)
      uni.showToast({
        title: '微信授权失败',
        icon: 'error'
      })
    }
  })
}

const getVerificationCode = () => {
  if (countdown.value > 0) return

  // 开始倒计时
  countdown.value = 60
  const timer = setInterval(() => {
    countdown.value--
    if (countdown.value <= 0) {
      clearInterval(timer)
    }
  }, 1000)

  // 发送验证码逻辑
  uni.showToast({
    title: '验证码已发送',
    icon: 'success'
  })
}

const confirmBind = () => {
  if (!canSubmit.value) return

  uni.showLoading({
    title: '绑定中...'
  })

  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({
      title: '绑定成功',
      icon: 'success'
    })

    // 返回上一页
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  }, 2000)
}
</script>

<style lang="scss" scoped>
.section {
  padding: 30rpx;
  background: var(--bg-primary);
  border-radius: 24rpx;
  box-shadow: var(--shadow-sm);

  .section-header {
    margin-bottom: 30rpx;

    .section-title {
      font-size: 32rpx;
      font-weight: bold;
      color: var(--text-primary);
    }
  }

  .section-subtitle {
    font-size: 28rpx;
    color: var(--text-secondary);
    margin-bottom: 15rpx;
  }
}

.bind-button {
  width: 100%;
  height: 80rpx;
  background: var(--primary-color);
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30rpx;

  .bind-text {
    font-size: 30rpx;
    color: var(--text-inverse);
    font-weight: 500;
  }

  &:active {
    background: var(--primary-dark);
  }
}

.current-wechat {
  margin-bottom: 30rpx;

  .wechat-info {
    display: flex;
    align-items: center;

    .wechat-avatar {
      margin-right: 30rpx;

      .avatar-img {
        width: 80rpx;
        height: 80rpx;
        border-radius: 50%;
      }
    }

    .wechat-details {
      display: flex;
      flex-direction: column;
      gap: 10rpx;

      .wechat-name {
        font-size: 30rpx;
        color: var(--text-primary);
        font-weight: 500;
      }

      .wechat-phone {
        font-size: 26rpx;
        color: var(--text-tertiary);
      }
    }

    .no-bind-text {
      font-size: 28rpx;
      color: var(--text-tertiary);
    }
  }
}

.phone-section {
  margin-bottom: 30rpx;

  .phone-text {
    font-size: 30rpx;
    color: var(--text-primary);
  }
}

.verification-section {
  .verification-input-group {
    display: flex;
    align-items: center;
    gap: 30rpx;

    .verification-input {
      flex: 1;
      height: 80rpx;
      padding: 0 30rpx;
      border: 2rpx solid var(--border-primary);
      border-radius: 16rpx;
      font-size: 28rpx;
      color: var(--text-primary);
      background: var(--bg-primary);
    }

    .verification-btn {
      width: 200rpx;
      height: 80rpx;
      background: var(--primary-color);
      border-radius: 16rpx;
      display: flex;
      align-items: center;
      justify-content: center;

      .btn-text {
        font-size: 26rpx;
        color: var(--text-inverse);
      }

      &:active {
        background: var(--primary-dark);
      }
    }
  }
}

.submit-section {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 30rpx;
  background: var(--bg-primary);
  box-shadow: var(--shadow-lg);

  .submit-btn {
    width: 100%;
    height: 80rpx;
    background: var(--bg-inverse);
    color: var(--text-inverse);
    border: none;
    border-radius: 16rpx;
    font-size: 32rpx;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;

    &.disabled {
      background: var(--bg-tertiary);
      color: var(--text-tertiary);
    }

    &:active:not(.disabled) {
      background: var(--text-primary);
    }
  }
}
</style> 