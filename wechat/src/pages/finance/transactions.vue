<script setup lang="ts">
import { reactive, ref } from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'

interface Transaction {
  id: string
  transactionId: string
  userId: string
  userName: string
  userAvatar: string
  type: 'income' | 'expense'
  amount: number
  description: string
  time: string
  remark?: string
}

const activeTab = ref('transactions')

const transactions = ref<Transaction[]>([
  {
    id: '1',
    transactionId: 'TX20220825081519',
    userId: '123212',
    userName: '陈',
    userAvatar: '/static/images/avatar.png',
    type: 'income',
    amount: 84.40,
    description: '会员开通',
    time: '2022-08-25 08:15:19',
  },
  {
    id: '2',
    transactionId: 'TX20220825081520',
    userId: '123213',
    userName: '李',
    userAvatar: '/static/images/avatar.png',
    type: 'income',
    amount: 84.40,
    description: '活动报名',
    time: '2022-08-25 08:15:20',
  },
  {
    id: '3',
    transactionId: 'TX20220825081521',
    userId: '123214',
    userName: '王',
    userAvatar: '/static/images/avatar.png',
    type: 'income',
    amount: 84.40,
    description: '数字人充值',
    time: '2022-08-25 08:15:21',
  },
  {
    id: '4',
    transactionId: 'TX20220825081522',
    userId: '123215',
    userName: '张',
    userAvatar: '/static/images/avatar.png',
    type: 'expense',
    amount: 84.40,
    description: '提现',
    time: '2022-08-25 08:15:22',
  },
  {
    id: '5',
    transactionId: 'TX20220825081523',
    userId: '123216',
    userName: '刘',
    userAvatar: '/static/images/avatar.png',
    type: 'expense',
    amount: 84.40,
    description: '系统扣除',
    time: '2022-08-25 08:15:23',
    remark: '用户123123退款, 系统扣除',
  },
  {
    id: '6',
    transactionId: 'TX20220825081524',
    userId: '123217',
    userName: '赵',
    userAvatar: '/static/images/avatar.png',
    type: 'income',
    amount: 84.40,
    description: '系统增加',
    time: '2022-08-25 08:15:24',
    remark: '暂无备注',
  },
])

const searchForm = reactive({
  keyword: '',
  transactionType: '',
  entryTime: '',
})

const transactionTypeOptions = [
  { label: '全部类型', value: '' },
  { label: '收入', value: 'income' },
  { label: '支出', value: 'expense' },
]

const timeOptions = [
  { label: '全部时间', value: '' },
  { label: '最近7天', value: '7days' },
  { label: '最近30天', value: '30days' },
  { label: '最近90天', value: '90days' },
]

function handleSearch() {
  // 实现搜索逻辑
  console.log('搜索:', searchForm)
}

function handleReset() {
  searchForm.keyword = ''
  searchForm.transactionType = ''
  searchForm.entryTime = ''
}

function copyTransactionId(id: string) {
  uni.setClipboardData({
    data: id,
    success: () => {
      uni.showToast({
        title: '已复制',
        icon: 'success',
      })
    },
  })
}

function formatAmount(amount: number, type: string) {
  const sign = type === 'income' ? '+' : '-'
  return `${sign}${amount.toFixed(2)}`
}

const value1 = ref('1')
const value2 = ref('1')
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="入账明细" :show-back="true" />

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 搜索和筛选 -->
      <view class="search-section">
        <view class="search-row">
          <sar-input v-model="searchForm.keyword" placeholder="交易编号、用户" class="search-input">
            <template #prepend>
              <text class="search-icon">🔍</text>
            </template>
          </sar-input>
        </view>

        <sar-dropdown class="filter-row">
          <sar-dropdown-item v-model="searchForm.transactionType" placeholder="交易类型" :options="transactionTypeOptions" />
          <sar-dropdown-item v-model="searchForm.entryTime" placeholder="入账时间" :options="timeOptions" />
        </sar-dropdown>

        <view class="button-row">
          <sar-button size="small" theme="primary" @click="handleSearch">
            查询
          </sar-button>
          <sar-button size="small" theme="default" @click="handleReset">
            重置
          </sar-button>
        </view>
      </view>

      <!-- 交易列表 -->
      <view class="transactions-list pb-10">
        <view
          v-for="transaction in transactions"
          :key="transaction.id"
          class="transaction-item"
        >
          <view class="transaction-header">
            <view class="user-info">
              <image :src="transaction.userAvatar" class="user-avatar" />
              <view class="user-details">
                <text class="user-name">{{ transaction.userName }}</text>
                <text class="user-id">(id:{{ transaction.userId }})</text>
              </view>
            </view>
            <view class="amount-section">
              <text class="amount-text" :class="transaction.type">
                {{ formatAmount(transaction.amount, transaction.type) }}
              </text>
            </view>
          </view>

          <view class="transaction-content">
            <view class="info-row">
              <text class="info-label">交易编号:</text>
              <view class="transaction-id">
                <text class="id-text">{{ transaction.transactionId }}</text>
                <sar-button
                  type="text"
                  size="small"
                  theme="primary"
                  @click="copyTransactionId(transaction.transactionId)"
                >
                  复制
                </sar-button>
              </view>
            </view>

            <view class="info-row">
              <text class="info-label">交易时间:</text>
              <text class="info-value">{{ transaction.time }}</text>
            </view>

            <view class="info-row">
              <text class="info-label">交易描述:</text>
              <text class="info-value">{{ transaction.description }}</text>
            </view>

            <view v-if="transaction.remark" class="info-row">
              <text class="info-label">备注:</text>
              <text class="info-value remark-text">{{ transaction.remark }}</text>
            </view>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.search-section {
  padding: var(--spacing-md) 0;
}

.search-row {
  margin-bottom: var(--spacing-sm);
}

.search-input {
  width: 100%;
}

.search-icon {
  font-size: 24rpx;
  color: var(--text-tertiary);
}

.button-row {
  display: flex;
  gap: var(--spacing-sm);
  margin-top: var(--spacing-sm);
}

.filter-row {
  display: flex;
  gap: var(--spacing-sm);
}

.filter-item {
  flex: 1;
}

.transaction-item {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
  border: 1px solid var(--border-primary);
}

.transaction-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: var(--spacing-sm);
  border-bottom: 1px dashed var(--border-primary);
}

.user-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.user-avatar {
  width: 64rpx;
  height: 64rpx;
  border-radius: 50%;
}

.user-details {
  display: flex;
  flex-direction: column;
}

.user-name {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.user-id {
  font-size: 22rpx;
  color: var(--text-secondary);
}

.amount-text {
  font-size: 32rpx;
  font-weight: bold;

  &.income {
    color: var(--success-color);
  }

  &.expense {
    color: var(--error-color);
  }
}

.transaction-content {
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

.transaction-id {
  display: flex;
  align-items: center;
  gap: var(--spacing-xs);
}

.id-text {
  font-size: 24rpx;
  color: var(--text-primary);
}

.remark-text {
  color: var(--text-tertiary);
  font-style: italic;
}
</style>

<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "入账明细"
}
}
</route>
