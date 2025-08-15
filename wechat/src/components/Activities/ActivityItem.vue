<!-- 活动订单子项组件 -->
<script setup lang="ts">
// 定义活动订单接口
interface Activity {
  orderNumber: string
  status: 'pending' | 'verified' | 'cancelled'
  name: string
  dateRange: string
  orderTime: string
  price: string
  paymentMethod: string
  image: string
}

// 定义组件Props，提供默认值
interface Props {
  activity: Activity
  showVerificationButton?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  showVerificationButton: true,
})

// 定义组件Emits
interface Emits {
  (e: 'click', activity: Activity): void
  (e: 'verificationClick', activity: Activity): void
}

const emit = defineEmits<Emits>()

// 方法定义
function getStatusClass(status: string): string {
  switch (status) {
    case 'pending':
      return 'status-pending'
    case 'verified':
      return 'status-verified'
    case 'cancelled':
      return 'status-cancelled'
    default:
      return ''
  }
}

function getStatusText(status: string): string {
  switch (status) {
    case 'pending':
      return '待核销'
    case 'verified':
      return '已核销'
    case 'cancelled':
      return '已取消'
    default:
      return '未知状态'
  }
}

function handleOrderClick() {
  emit('click', props.activity)
}

function handleVerificationClick(event: Event) {
  event.stopPropagation()
  emit('verificationClick', props.activity)
}

function handleImageError() {
  console.warn('活动图片加载失败:', props.activity.image)
}
</script>

<template>
  <view class="activity-item" @click="handleOrderClick">
    <!-- 订单头部 -->
    <view class="order-header">
      <text class="order-number">订单编号: {{ activity.orderNumber }}</text>
      <view class="order-status" :class="getStatusClass(activity.status)">
        {{ getStatusText(activity.status) }}
      </view>
    </view>

    <!-- 活动信息 -->
    <view class="activity-info">
      <view class="activity-image">
        <image 
          :src="activity.image" 
          class="activity-img" 
          mode="aspectFill"
          @error="handleImageError"
        />
      </view>
      <view class="activity-details">
        <text class="activity-name">{{ activity.name }}</text>
        <text class="activity-date">{{ activity.dateRange }}</text>
        <view 
          v-if="showVerificationButton"
          class="verification-btn" 
          @click="handleVerificationClick"
        >
          查看核销码
        </view>
      </view>
    </view>

    <!-- 订单底部 -->
    <view class="order-footer">
      <text class="order-time">{{ activity.orderTime }}</text>
      <view class="order-price">
        <text class="price-amount">¥{{ activity.price }}</text>
        <text class="payment-method">({{ activity.paymentMethod }})</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.activity-item {
  background: var(--bg-primary);
  border-radius: 24rpx;
  padding: 40rpx;
  margin-bottom: 20rpx;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  
  &:active {
    transform: scale(0.98);
    box-shadow: var(--shadow-md);
  }
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30rpx;

  .order-number {
    font-size: 26rpx;
    color: var(--text-tertiary);
  }

  .order-status {
    font-size: 26rpx;
    font-weight: 500;

    &.status-pending {
      color: var(--text-tertiary);
    }

    &.status-verified {
      color: var(--error-color);
    }

    &.status-cancelled {
      color: var(--warning-color);
    }
  }
}

.activity-info {
  display: flex;
  gap: 30rpx;
  margin-bottom: 30rpx;

  .activity-image {
    .activity-img {
      width: 120rpx;
      height: 120rpx;
      border-radius: 16rpx;
      object-fit: cover;
    }
  }

  .activity-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 15rpx;

    .activity-name {
      font-size: 30rpx;
      font-weight: bold;
      color: var(--text-primary);
      line-height: 1.4;
    }

    .activity-date {
      font-size: 26rpx;
      color: var(--text-secondary);
    }

    .verification-btn {
      align-self: flex-start;
      padding: 15rpx 30rpx;
      background: var(--primary-color);
      color: var(--text-inverse);
      border-radius: 20rpx;
      font-size: 24rpx;
      cursor: pointer;
      transition: background-color 0.2s ease;

      &:active {
        background: var(--primary-dark);
      }
    }
  }
}

.order-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 20rpx;
  border-top: 2rpx solid var(--border-secondary);

  .order-time {
    font-size: 26rpx;
    color: var(--text-tertiary);
  }

  .order-price {
    display: flex;
    align-items: center;
    gap: 10rpx;

    .price-amount {
      font-size: 30rpx;
      font-weight: bold;
      color: var(--text-primary);
    }

    .payment-method {
      font-size: 24rpx;
      color: var(--text-tertiary);
    }
  }
}
</style>
