<template>
  <view class="withdrawal-entry" @click="goToWithdrawal">
    <view class="entry-content">
      <view class="entry-left">
        <view class="entry-icon">
          <text class="iconfont icon-target"></text>
        </view>
        <view class="entry-info">
          <text class="entry-title">提现</text>
          <text class="entry-subtitle">可提现余额 ¥{{ availableBalance }}</text>
        </view>
      </view>
      <view class="entry-right">
        <text class="iconfont icon-arrow-right"></text>
      </view>
    </view>
  </view>
</template>

<script lang="ts" setup>
import { ref } from 'vue'

defineOptions({
  name: 'WithdrawalEntry',
})

// Props
interface Props {
  availableBalance?: number
}

const props = withDefaults(defineProps<Props>(), {
  availableBalance: 0
})

// 方法
const goToWithdrawal = () => {
  uni.navigateTo({
    url: '/pages/withdrawal/index'
  })
}
</script>

<style lang="scss" scoped>
.withdrawal-entry {
  background: var(--bg-primary);
  border-radius: 16rpx;
  padding: 30rpx;
  margin: 20rpx 0;
  box-shadow: var(--shadow-sm);
  
  .entry-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .entry-left {
      display: flex;
      align-items: center;
      gap: 30rpx;
      
      .entry-icon {
        width: 80rpx;
        height: 80rpx;
        background: var(--primary-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        
        .iconfont {
          font-size: 40rpx;
          color: var(--text-inverse);
        }
      }
      
      .entry-info {
        display: flex;
        flex-direction: column;
        gap: 10rpx;
        
        .entry-title {
          font-size: 32rpx;
          font-weight: bold;
          color: var(--text-primary);
        }
        
        .entry-subtitle {
          font-size: 26rpx;
          color: var(--text-tertiary);
        }
      }
    }
    
    .entry-right {
      .iconfont {
        font-size: 32rpx;
        color: var(--text-tertiary);
      }
    }
  }
  
  &:active {
    background: var(--bg-tertiary);
  }
}
</style> 