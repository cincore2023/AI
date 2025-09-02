<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "提现"
}
}
</route>

<script lang="ts" setup>
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
// 响应式数据
const withdrawalAmount = ref('')
const selectedMethod = ref('alipay')
const verificationCode = ref('')
const countdown = ref(0)
const isWechatBound = ref(false)

// 模拟数据
const availableBalance = ref(852.12)
const remainingAttempts = ref(3)
const remainingQuota = ref(20000)
const accountName = ref('Dil')
const maskedPhone = ref('185****0617')

// 计算属性
const canSubmit = computed(() => {
  return withdrawalAmount.value &&
      verificationCode.value &&
      parseFloat(withdrawalAmount.value) > 0 &&
      parseFloat(withdrawalAmount.value) <= availableBalance.value &&
      parseFloat(withdrawalAmount.value) <= remainingQuota.value
})

// 方法
const onAmountInput = (e: any) => {
  const value = e.detail.value
  // 限制只能输入数字和小数点
  withdrawalAmount.value = value.replace(/[^\d.]/g, '')
}

const selectMethod = (method: string) => {
  selectedMethod.value = method
}

const bindAccount = () => {
  uni.navigateTo({
    url: '/pages/withdrawal/bind-account'
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

const submitWithdrawal = () => {
  if (!canSubmit.value) return

  // 验证提现金额
  const amount = parseFloat(withdrawalAmount.value)
  if (amount > availableBalance.value) {
    uni.showToast({
      title: '提现金额不能大于可提现余额',
      icon: 'error'
    })
    return
  }

  if (amount > remainingQuota.value) {
    uni.showToast({
      title: '提现金额不能大于今日剩余额度',
      icon: 'error'
    })
    return
  }

  // 提交提现申请
  uni.showLoading({
    title: '提交中...'
  })

  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({
      title: '提现申请已提交',
      icon: 'success'
    })

    // 重置表单
    withdrawalAmount.value = ''
    verificationCode.value = ''
  }, 2000)
}

onMounted(() => {
  // 检查微信绑定状态
  // 这里可以根据实际业务逻辑来判断
  isWechatBound.value = true
})
</script>

<template>
  <view class="default-layout-content">

    <HeaderSimple title="提现申请" :show-back="true"/>

    <scroll-view class="no-scrollbar flex flex-1 flex-col" :scroll-y="true" :show-scrollbar="false" enhanced="true">

      <!-- 提现金额 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">提现金额</text>
          <text class="balance-info">(可提现余额 ¥{{ availableBalance }})</text>
        </view>

        <view class="amount-input">
          <text class="currency-symbol">¥</text>
          <input
              class="amount-field"
              type="number"
              v-model="withdrawalAmount"
              placeholder="请输入提现金额"
              @input="onAmountInput"
          />
        </view>

        <view class="rules">
          <text class="rule-text">不可大于可提现余额,单次/单日申请不超过20000元</text>
        </view>

        <view class="limits">
          <view class="limit-item">
            <text class="limit-label">今日剩余次数:</text>
            <text class="limit-value">{{ remainingAttempts }}次</text>
          </view>
          <view class="limit-item">
            <text class="limit-label">今日剩余额度:</text>
            <text class="limit-value">¥{{ remainingQuota }}</text>
          </view>
        </view>
      </view>

      <!-- 提现方式 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">提现方式</text>
        </view>
        <view class="payment-methods">
          <view
              class="method-item"
              :class="{ active: selectedMethod === 'alipay' }"
              @click="selectMethod('alipay')"
          >
            <view class="method-radio">
              <view class="radio-inner" v-if="selectedMethod === 'alipay'"></view>
            </view>
            <text class="method-name">支付宝</text>
          </view>
          <view
              class="method-item"
              :class="{ active: selectedMethod === 'wechat' }"
              @click="selectMethod('wechat')"
          >
            <view class="method-radio">
              <view class="radio-inner" v-if="selectedMethod === 'wechat'"></view>
            </view>
            <text class="method-name">微信</text>
          </view>
        </view>
      </view>

      <!-- 收款账号 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">收款账号</text>
          <text class="bind-link" @click="bindAccount">绑定支付宝</text>
        </view>
        <view class="account-info">
          <view class="account-avatar">
            <image src="/static/images/avatar.png" class="avatar-img"/>
          </view>
          <view class="account-details">
            <text class="account-name">{{ accountName }}</text>
            <text class="account-phone">{{ maskedPhone }}</text>
          </view>
        </view>
      </view>

      <!-- 验证码 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">验证码</text>
        </view>
        <view class="verification-section">
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

      <!-- 温馨提示 -->
      <view class="section mb-0!">
        <view class="section-header">
          <text class="section-title">温馨提示:</text>
        </view>
        <view class="tips-content">
          <text class="tips-text">
            单日提现不超过2万。提现金额会分多笔转入,每笔不超过500元。如提现2万,则会分为40笔500元转入您的微信零钱账户。提现需收取千分之6交易手续费以及3%增值税。
          </text>
        </view>
      </view>

    </scroll-view>

    <!-- 申请提现按钮 -->
    <view class="submit-section">
      <button
          class="submit-btn"
          :class="{ disabled: !canSubmit }"
          :disabled="!canSubmit"
          @click="submitWithdrawal"
      >
        申请提现
      </button>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.section {
  padding: 20rpx;
  background: var(--bg-primary);
  border-radius: 20rpx;
  box-shadow: var(--shadow-sm);
  margin-bottom: 16rpx;

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20rpx;

    .section-title {
      font-size: 30rpx;
      font-weight: bold;
      color: var(--text-primary);
    }

    .balance-info {
      font-size: 22rpx;
      color: var(--text-tertiary);
    }

    .bind-link {
      font-size: 26rpx;
      color: var(--primary-color);
    }
  }
}

.amount-input {
  display: flex;
  align-items: center;
  margin-bottom: 16rpx;

  .currency-symbol {
    font-size: 56rpx;
    font-weight: bold;
    color: var(--text-primary);
    margin-right: 16rpx;
  }

  .amount-field {
    flex: 1;
    font-size: 44rpx;
    font-weight: bold;
    color: var(--text-primary);
    border: none;
    outline: none;
  }
}

.rules {
  margin-bottom: 20rpx;

  .rule-text {
    font-size: 22rpx;
    color: var(--text-tertiary);
    line-height: 1.4;
  }
}

.limits {
  .limit-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12rpx;

    .limit-label {
      font-size: 24rpx;
      color: var(--text-secondary);
    }

    .limit-value {
      font-size: 24rpx;
      color: var(--text-primary);
      font-weight: 500;
    }
  }
}

.payment-methods {
  .method-item {
    display: flex;
    align-items: center;
    padding: 20rpx 0;
    border-bottom: 2rpx solid var(--border-secondary);

    &:last-child {
      border-bottom: none;
    }

    .method-radio {
      width: 36rpx;
      height: 36rpx;
      border: 4rpx solid var(--border-primary);
      border-radius: 50%;
      margin-right: 24rpx;
      display: flex;
      align-items: center;
      justify-content: center;

      .radio-inner {
        width: 18rpx;
        height: 18rpx;
        background: var(--primary-color);
        border-radius: 50%;
      }
    }

    .method-name {
      font-size: 28rpx;
      color: var(--text-primary);
    }

    &.active {
      .method-radio {
        border-color: var(--primary-color);
      }
    }
  }
}

.account-info {
  display: flex;
  align-items: center;

  .account-avatar {
    margin-right: 24rpx;

    .avatar-img {
      width: 70rpx;
      height: 70rpx;
      border-radius: 50%;
    }
  }

  .account-details {
    display: flex;
    flex-direction: column;
    gap: 8rpx;

    .account-name {
      font-size: 28rpx;
      color: var(--text-primary);
      font-weight: 500;
    }

    .account-phone {
      font-size: 24rpx;
      color: var(--text-tertiary);
    }
  }
}

.verification-section {
  display: flex;
  align-items: center;
  gap: 24rpx;

  .verification-input {
    flex: 1;
    height: 70rpx;
    padding: 0 24rpx;
    border: 2rpx solid var(--border-primary);
    border-radius: 14rpx;
    font-size: 26rpx;
    color: var(--text-primary);
    background: var(--bg-primary);
  }

  .verification-btn {
    width: 180rpx;
    height: 70rpx;
    background: var(--primary-color);
    border-radius: 14rpx;
    display: flex;
    align-items: center;
    justify-content: center;

    .btn-text {
      font-size: 24rpx;
      color: var(--text-inverse);
    }

    &:active {
      background: var(--primary-dark);
    }
  }
}

.tips-content {
  .tips-text {
    font-size: 24rpx;
    color: var(--text-tertiary);
    line-height: 1.5;
  }
}

.submit-section {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 32rpx;
  background: var(--bg-primary);
  box-shadow: var(--shadow-lg);

  .submit-btn {
    width: 100%;
    height: 90rpx;
    background: var(--bg-inverse);
    color: var(--text-inverse);
    border: none;
    border-radius: 14rpx;
    font-size: 30rpx;
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