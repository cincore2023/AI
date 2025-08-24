<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "兑换码"
}
}
</route>

<script setup lang="ts">
import {ref, computed, onMounted} from 'vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'

// 筛选选项
const selectedType = ref('')
const showTypeFilter = ref(false)

const typeOptions = [
  {label: '全部类型', value: ''},
  {label: '系统增加', value: 'increase'},
  {label: '开通会员', value: 'membership'},
  {label: '系统扣除', value: 'deduction'},
  {label: '其他', value: 'other'},
]

// 兑换码交易记录数据
const exchangeRecords = ref([
  {
    id: '1',
    type: 'increase',
    title: '系统增加',
    amount: 30,
    date: '2021-12-12 23:59:59',
    transactionId: '123123123123123',
    remark: '购买产品包赠送',
    isPositive: true,
  },
  {
    id: '2',
    type: 'membership',
    title: '开通会员',
    amount: 1,
    date: '2021-12-12 23:59:59',
    transactionId: '123123123123123',
    details: '微信昵称+用户ID12321 开通会员使用',
    isPositive: false,
  },
  {
    id: '3',
    type: 'deduction',
    title: '系统扣除',
    amount: 1,
    date: '2021-12-12 23:59:59',
    transactionId: '123123123123123',
    remark: '微信昵称+用户ID12321 开通会员使用',
    isPositive: false,
  },
  {
    id: '4',
    type: 'increase',
    title: '系统增加',
    amount: 50,
    date: '2021-12-01 10:30:00',
    transactionId: '123123123123124',
    remark: '活动奖励',
    isPositive: true,
  },
  {
    id: '5',
    type: 'deduction',
    title: '系统扣除',
    amount: 5,
    date: '2021-11-28 15:20:00',
    transactionId: '123123123123125',
    remark: '课程购买',
    isPositive: false,
  },
])

// 筛选后的记录
const filteredRecords = computed(() => {
  if (!selectedType.value) {
    return exchangeRecords.value
  }
  return exchangeRecords.value.filter(record => record.type === selectedType.value)
})

// 显示类型筛选
function showTypeFilterModal() {
  showTypeFilter.value = true
}

// 选择类型
function selectType(type: string) {
  selectedType.value = type
  showTypeFilter.value = false
}

// 获取金额显示样式
function getAmountStyle(record: any) {
  return {
    color: record.isPositive ? 'var(--success-color)' : 'var(--error-color)',
    fontWeight: 'bold',
  }
}

// 获取金额显示文本
function getAmountText(record: any) {
  return record.isPositive ? `+${record.amount}` : `-${record.amount}`
}

onMounted(() => {
  console.log('兑换码详情页面已加载')
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="兑换码" :show-back="true"/>

    <!-- 筛选选项 -->
    <view class="filter-section">
      <view class="filter-item" @click="showTypeFilterModal">
        <text class="filter-label">类型</text>
        <sar-icon name="arrow-down" size="16" color="var(--text-tertiary)"/>
      </view>
    </view>

    <scroll-view
        class="no-scrollbar flex flex-1 flex-col"
        :scroll-y="true"
        :show-scrollbar="false"
        enhanced="true"
    >
      <!-- 交易记录列表 -->
      <view class="exchange-list pb-10">
        <view
            v-for="record in filteredRecords"
            :key="record.id"
            class="exchange-item"
        >
          <view class="exchange-header">
            <view class="exchange-title">
              <text class="title-text" :style="getAmountStyle(record)">
                {{ record.title }}
              </text>
            </view>
            <view class="amount-section">
              <text class="amount-text" :style="getAmountStyle(record)">
                {{ getAmountText(record) }}
              </text>
            </view>
          </view>

          <view class="exchange-content">
            <view class="info-row">
              <text class="info-label">交易编号:</text>
              <text class="info-value">{{ record.transactionId }}</text>
            </view>

            <view class="info-row">
              <text class="info-label">交易时间:</text>
              <text class="info-value">{{ record.date }}</text>
            </view>

            <view v-if="record.remark" class="info-row">
              <text class="info-label">备注:</text>
              <text class="info-value remark-text">{{ record.remark }}</text>
            </view>

            <view v-if="record.details" class="info-row">
              <text class="info-label">详情:</text>
              <text class="info-value remark-text">{{ record.details }}</text>
            </view>
          </view>
        </view>
      </view>

      <!-- 空状态 -->
      <view v-if="filteredRecords.length === 0" class="empty-state">
        <view class="empty-icon">
          <sar-icon name="info-circle" size="60" color="var(--text-tertiary)"/>
        </view>
        <text class="empty-text">暂无兑换码记录</text>
      </view>
    </scroll-view>

    <!-- 类型筛选弹窗 -->
    <sar-popup v-model:visible="showTypeFilter" effect="slide-bottom">
      <view class="filter-popup">
        <view class="filter-popup-header">
          <text class="filter-popup-title">选择类型</text>
          <sar-icon
              name="close"
              size="20"
              color="#999"
              @click="showTypeFilter = false"
          />
        </view>
        <view class="filter-options">
          <view
              v-for="option in typeOptions"
              :key="option.value"
              class="filter-option"
              :class="{ active: selectedType === option.value }"
              @click="selectType(option.value)"
          >
            <text class="filter-option-text">{{ option.label }}</text>
            <sar-icon
                v-if="selectedType === option.value"
                name="check"
                size="16"
                color="#007aff"
            />
          </view>
        </view>
      </view>
    </sar-popup>
  </view>
</template>

<style lang="scss" scoped>
.filter-section {
  padding: var(--spacing-md) 0;
}

.filter-item {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
  padding: var(--spacing-sm) var(--spacing-md);
  background: var(--bg-tertiary);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: background-color 0.2s ease;

  &:active {
    background: var(--bg-secondary);
  }

  .filter-label {
    font-size: 28rpx;
    color: var(--text-primary);
  }
}

.exchange-item {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
  border: 1px solid var(--border-primary);
}

.exchange-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: var(--spacing-sm);
  border-bottom: 1px dashed var(--border-primary);
}

.exchange-title {
  .title-text {
    font-size: 28rpx;
    font-weight: bold;
    color: var(--text-primary);
  }
}

.amount-section {
  .amount-text {
    font-size: 32rpx;
    font-weight: bold;
  }
}

.exchange-content {
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

.remark-text {
  color: var(--text-tertiary);
  font-style: italic;
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

.filter-popup {
  background: #fff;
  border-radius: 24rpx 24rpx 0 0;
  padding: 32rpx;
  max-height: 60vh;
}

.filter-popup-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 32rpx;

  .filter-popup-title {
    font-size: 32rpx;
    font-weight: 600;
    color: var(--text-primary);
  }
}

.filter-options {
  .filter-option {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 24rpx 0;
    border-bottom: 1px solid var(--border-primary);

    &:last-child {
      border-bottom: none;
    }

    &.active {
      .filter-option-text {
        color: #007aff;
        font-weight: 600;
      }
    }

    .filter-option-text {
      font-size: 28rpx;
      color: var(--text-primary);
    }
  }
}
</style> 