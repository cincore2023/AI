<script setup lang="ts">
import { reactive, ref } from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'

interface WithdrawalRecord {
  id: string
  status: 'approving' | 'withdrawing' | 'completed' | 'error' | 'rejected'
  statusText: string
  applyTime: string
  amount: number
  balanceAfter: number
  actualAmount?: number
  completeTime?: string
  errorReason?: string
}

const activeTab = ref('withdrawal')

const withdrawalRecords = ref<WithdrawalRecord[]>([
  {
    id: '1',
    status: 'approving',
    statusText: '审批中',
    applyTime: '2021-12-12 23:59:59',
    amount: 50000,
    balanceAfter: 100.00,
  },
  {
    id: '2',
    status: 'withdrawing',
    statusText: '提现中',
    applyTime: '2021-12-12 23:59:59',
    amount: 50000,
    balanceAfter: 100.00,
  },
  {
    id: '3',
    status: 'completed',
    statusText: '已完成',
    applyTime: '2021-12-12 23:59:59',
    amount: 50000,
    balanceAfter: 100.00,
    actualAmount: 48200,
    completeTime: '2021-12-12 23:12:12',
  },
  {
    id: '4',
    status: 'error',
    statusText: '错误',
    applyTime: '2021-12-12 23:59:59',
    amount: 50000,
    balanceAfter: 100.00,
    errorReason: '银行账户信息错误',
  },
  {
    id: '5',
    status: 'rejected',
    statusText: '已拒绝',
    applyTime: '2021-12-12 23:59:59',
    amount: 50000,
    balanceAfter: 100.00,
    errorReason: '余额不足',
  },
])

const filters = reactive({
  status: '',
  applyTime: '',
})

const statusOptions = [
  { label: '全部', value: '' },
  { label: '审批中', value: 'approving' },
  { label: '提现中', value: 'withdrawing' },
  { label: '已完成', value: 'completed' },
  { label: '错误', value: 'error' },
  { label: '已拒绝', value: 'rejected' },
]

const timeOptions = [
  { label: '全部时间', value: '' },
  { label: '最近7天', value: '7days' },
  { label: '最近30天', value: '30days' },
  { label: '最近90天', value: '90days' },
]

function getStatusColor(status: string) {
  const colorMap = {
    approving: 'warning',
    withdrawing: 'info',
    completed: 'success',
    error: 'danger',
    rejected: 'danger',
  }
  return colorMap[status] || 'default'
}

function formatAmount(amount: number) {
  return (amount / 1000).toFixed(3)
}
</script>

<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "账户余额管理"
}
}
</route>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="账户余额管理" :show-back="true" />

    <!-- 筛选器 -->
    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 记录列表 -->
      <view class="records-list mb-10">
        <view
          v-for="record in withdrawalRecords"
          :key="record.id"
          class="record-item"
        >
          <view class="record-header">
            <view class="status-section">
              <sar-tag :theme="getStatusColor(record.status)" size="small">
                {{ record.statusText }}
              </sar-tag>
            </view>
            <view class="amount-section">
              <text class="amount-text">{{ formatAmount(record.amount) }}</text>
            </view>
          </view>

          <view class="record-content">
            <view class="info-row">
              <text class="info-label">申请时间:</text>
              <text class="info-value">{{ record.applyTime }}</text>
            </view>

            <view class="info-row">
              <text class="info-label">提现后余额:</text>
              <text class="info-value">{{ record.balanceAfter }}</text>
            </view>

            <view class="info-row">
              <text class="info-label">详情:</text>
              <text class="info-value">提现申请</text>
            </view>

            <view v-if="record.actualAmount" class="info-row">
              <text class="info-label">实际到账:</text>
              <text class="info-value">{{ record.actualAmount }}</text>
            </view>

            <view v-if="record.completeTime" class="info-row">
              <text class="info-label">完成时间:</text>
              <text class="info-value">{{ record.completeTime }}</text>
            </view>

            <view v-if="record.errorReason" class="info-row">
              <text class="info-label">拒绝原因:</text>
              <text class="info-value error-text">{{ record.errorReason }}</text>
            </view>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.tab-container {
  background-color: var(--bg-primary);
  border-bottom: 1px solid var(--border-primary);
}

.filter-section {
  background-color: var(--bg-primary);
  padding: var(--spacing-md);
  border-bottom: 1px solid var(--border-primary);
}

.filter-row {
  display: flex;
  gap: var(--spacing-md);
}

.filter-item {
  flex: 1;
}

.record-item {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
  border: 1px solid var(--border-primary);
}

.record-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--spacing-md);
  padding-bottom: var(--spacing-sm);
  border-bottom: 1px solid var(--border-primary);
}

.status-section {
  display: flex;
  align-items: center;
}

.amount-section {
  display: flex;
  align-items: center;
}

.amount-text {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.record-content {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-xs);
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.info-label {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.info-value {
  font-size: 24rpx;
  color: var(--text-primary);
}

.error-text {
  color: var(--error-color);
}
</style>
