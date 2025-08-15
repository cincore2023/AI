<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "我的活动"
}
}
</route>

<script lang="ts" setup>
import {computed, onMounted, ref} from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import FilterModal from '@/components/Activities/FilterModal.vue'
import ActivityItem from '@/components/Activities/ActivityItem.vue'

defineOptions({
  name: 'ActivitiesPage',
})

// 响应式数据
const showStatusModal = ref(false)
const showTimeModal = ref(false)
const selectedStatus = ref('')
const selectedTimeRange = ref('')

// 筛选选项
const statusOptions = [
  {label: '全部', value: ''},
  {label: '待核销', value: 'pending'},
  {label: '已核销', value: 'verified'},
  {label: '已取消', value: 'cancelled'},
]

const timeOptions = [
  {label: '全部时间', value: ''},
  {label: '最近一周', value: 'week'},
  {label: '最近一月', value: 'month'},
  {label: '最近三月', value: 'quarter'},
  {label: '最近半年', value: 'halfYear'},
]

// 模拟活动数据
const activities = ref([
  {
    orderNumber: '123123123123123',
    status: 'pending',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '线上支付',
    image: '/static/images/default-avatar.png',
  },
  {
    orderNumber: '12312312312312',
    status: 'verified',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '兑换码支付',
    image: '/static/images/default-avatar.png',
  }, {
    orderNumber: '123123123123123',
    status: 'pending',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '线上支付',
    image: '/static/images/default-avatar.png',
  },
  {
    orderNumber: '12312312312312',
    status: 'verified',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '兑换码支付',
    image: '/static/images/default-avatar.png',
  }, {
    orderNumber: '123123123123123',
    status: 'pending',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '线上支付',
    image: '/static/images/default-avatar.png',
  },
  {
    orderNumber: '12312312312312',
    status: 'verified',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '兑换码支付',
    image: '/static/images/default-avatar.png',
  }, {
    orderNumber: '123123123123123',
    status: 'pending',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '线上支付',
    image: '/static/images/default-avatar.png',
  },
  {
    orderNumber: '12312312312312',
    status: 'verified',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '兑换码支付',
    image: '/static/images/default-avatar.png',
  }, {
    orderNumber: '123123123123123',
    status: 'pending',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '线上支付',
    image: '/static/images/default-avatar.png',
  },
  {
    orderNumber: '12312312312312',
    status: 'verified',
    name: '三天两夜AI活动实操课',
    dateRange: '2022-08-25~2022-08-26',
    orderTime: '2025-02-02 18:33:33',
    price: '998.00',
    paymentMethod: '兑换码支付',
    image: '/static/images/default-avatar.png',
  },
])

// 计算属性
const filteredActivities = computed(() => {
  let result = activities.value

  // 按状态筛选
  if (selectedStatus.value) {
    result = result.filter(activity => activity.status === selectedStatus.value)
  }

  // 按时间筛选
  if (selectedTimeRange.value) {
    // 这里可以根据实际需求实现时间筛选逻辑
    // 暂时返回所有数据
  }

  return result
})

// 方法
function showStatusFilter() {
  showStatusModal.value = true
}

function showTimeFilter() {
  showTimeModal.value = true
}

function selectStatus(status: string) {
  selectedStatus.value = status
}

function selectTimeRange(timeRange: string) {
  selectedTimeRange.value = timeRange
}

function viewActivityDetail(activity: any) {
  uni.navigateTo({
    url: `/pages/activities/detail?orderNumber=${activity.orderNumber}`,
  })
}

function viewVerificationCode(activity: any) {
  uni.navigateTo({
    url: `/pages/activities/verification?orderNumber=${activity.orderNumber}`,
  })
}

onMounted(() => {
  // 页面加载时的初始化逻辑
  console.log('我的活动页面已加载')
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="我的活动" :show-back="true"/>

    <!-- 筛选选项 -->
    <view class="filter-section">
      <view class="filter-item" @click="showStatusFilter">
        <text class="filter-label">核销状态</text>
        <text class="filter-arrow">▼</text>
      </view>
      <view class="filter-item" @click="showTimeFilter">
        <text class="filter-label">报名时间</text>
        <text class="filter-arrow">▼</text>
      </view>
    </view>

    <scroll-view class="no-scrollbar flex flex-1 flex-col" :scroll-y="true" :show-scrollbar="false" enhanced="true">
      <!-- 活动订单列表 -->
      <ActivityItem
        v-for="activity in filteredActivities"
        :key="activity.orderNumber"
        :activity="activity"
        @click="viewActivityDetail"
        @verification-click="viewVerificationCode"
      />
    </scroll-view>

    <!-- 空状态 -->
    <view v-if="filteredActivities.length === 0" class="empty-state">
      <view class="empty-icon">
        <text class="iconfont icon-info"/>
      </view>
      <text class="empty-text">暂无活动订单</text>
    </view>

    <!-- 状态筛选弹窗 -->
    <FilterModal
      v-model:visible="showStatusModal"
      title="选择核销状态"
      :options="statusOptions"
      :selected-value="selectedStatus"
      @select="selectStatus"
    />

    <!-- 时间筛选弹窗 -->
    <FilterModal
      v-model:visible="showTimeModal"
      title="选择时间范围"
      :options="timeOptions"
      :selected-value="selectedTimeRange"
      @select="selectTimeRange"
    />
  </view>
</template>

<style lang="scss" scoped>
.filter-section {
  display: flex;
  gap: 20rpx;
  padding-bottom: 20rpx;

  .filter-item {
    display: flex;
    align-items: center;
    gap: 10rpx;
    padding: 20rpx 30rpx;
    background: var(--bg-tertiary);
    border-radius: 16rpx;
    cursor: pointer;
    transition: background-color 0.2s ease;

    &:active {
      background: var(--bg-secondary);
    }

    .filter-label {
      font-size: 28rpx;
      color: var(--text-primary);
    }

    .filter-arrow {
      font-size: 20rpx;
      color: var(--text-tertiary);
    }
  }
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 40rpx;

  .empty-icon {
    width: 120rpx;
    height: 120rpx;
    background: var(--bg-tertiary);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 30rpx;

    .iconfont {
      font-size: 60rpx;
      color: var(--text-tertiary);
    }
  }

  .empty-text {
    font-size: 28rpx;
    color: var(--text-tertiary);
  }
}
</style>
