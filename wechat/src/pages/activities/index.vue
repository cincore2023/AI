<route lang="jsonc" type="page">
{
  "layout": "default",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "我的活动"
  }
}
</route>

<script setup lang="ts">
import type { WxUserRegisteredActivityItem } from '@/api/types/activity'
import dayjs from 'dayjs'
import { computed, onMounted, ref } from 'vue'
import { wxGetUserRegisteredActivities } from '@/api/activity'
import FilterModal from '@/components/Activities/FilterModal.vue'
import MyActivityItem from '@/components/Activities/MyActivityItem.vue'
import VerificationCodeQR from '@/components/Activity/VerificationCodeQR.vue'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import { toast } from '@/utils/toast'

defineOptions({
  name: 'ActivitiesPage',
})

// 筛选状态
const showStatusFilter = ref(false)
const showTimeFilter = ref(false)
const selectedStatus = ref('')
const selectedTimeRange = ref('')
const qrShow = ref(false)
const qrText = ref('')

// 加载状态
const loading = ref(false)

// 筛选选项
const statusOptions = [
  { label: '全部', value: '' },
  { label: '待核销', value: 'pending' },
  { label: '已核销', value: 'paid' },
  { label: '已取消', value: 'cancelled' },
]

const timeOptions = [
  { label: '全部时间', value: '' },
  { label: '最近一周', value: 'week' },
  { label: '最近一月', value: 'month' },
  { label: '最近三月', value: 'quarter' },
  { label: '最近半年', value: 'halfYear' },
]

// 活动数据
const activities = ref<WxUserRegisteredActivityItem[]>([])

// 筛选后的活动列表
const filteredActivities = computed(() => {
  let result = activities.value

  // 按状态筛选
  if (selectedStatus.value) {
    result = result.filter(activity => activity.paymentStatus === selectedStatus.value)
  }

  // 按时间筛选
  if (selectedTimeRange.value) {
    const now = dayjs()
    result = result.filter((activity) => {
      const activityDate = dayjs(activity.createdAt)
      switch (selectedTimeRange.value) {
        case 'day':
          return activityDate.isAfter(now.subtract(1, 'day'))
        case 'week':
          return activityDate.isAfter(now.subtract(1, 'week'))
        case 'month':
          return activityDate.isAfter(now.subtract(1, 'month'))
        case 'quarter':
          return activityDate.isAfter(now.subtract(3, 'months'))
        case 'halfYear':
          return activityDate.isAfter(now.subtract(6, 'months'))
        case 'year':
          return activityDate.isAfter(now.subtract(1, 'year'))
        default:
          return true
      }
    })
  }

  return result
})

// 显示状态筛选
function showStatusFilterModal() {
  showStatusFilter.value = true
}

// 显示时间筛选
function showTimeFilterModal() {
  showTimeFilter.value = true
}

// 选择状态
function selectStatus(status: string) {
  selectedStatus.value = status
}

// 选择时间范围
function selectTimeRange(timeRange: string) {
  selectedTimeRange.value = timeRange
}

// 查看核销码
function viewVerificationCode(activity: WxUserRegisteredActivityItem) {
  qrText.value = activity.verificationCode
  qrShow.value = true
}

// 获取用户已报名的活动列表
async function getUserRegisteredActivities() {
  loading.value = true
  try {
    const res = await wxGetUserRegisteredActivities({
      page: 1,
      pageSize: 100, // 获取所有活动
    })

    activities.value = res.data.activities
  }
  catch (error) {
    console.error('获取用户已报名活动失败:', error)
    toast.error('获取活动列表失败')
  }
  finally {
    loading.value = false
  }
}

onMounted(() => {
  console.log('我的活动页面已加载')
  getUserRegisteredActivities()
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="我的活动" :show-back="true" />

    <!-- 筛选选项 -->
    <view class="filter-section">
      <view class="filter-item" @click="showStatusFilterModal">
        <text class="filter-label">核销状态</text>
        <sar-icon name="arrow-down" size="16" color="var(--text-tertiary)" />
      </view>
      <view class="filter-item" @click="showTimeFilterModal">
        <text class="filter-label">报名时间</text>
        <sar-icon name="arrow-down" size="16" color="var(--text-tertiary)" />
      </view>
    </view>

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <!-- 加载状态 -->
      <sar-skeleton v-if="loading" />

      <!-- 活动列表 -->
      <view v-else class="activities-list">
        <MyActivityItem
          v-for="activity in filteredActivities"
          :key="activity.orderNumber"
          :activity="activity"
          @verification-click="viewVerificationCode"
        />
      </view>

      <!-- 空状态 -->
      <view v-if="!loading && filteredActivities.length === 0" class="empty-state">
        <view class="empty-icon">
          <sar-icon name="info-circle" size="60" color="var(--text-tertiary)" />
        </view>
        <text class="empty-text">暂无活动订单</text>
      </view>
    </scroll-view>

    <!-- 状态筛选弹窗 -->
    <FilterModal
      v-model:visible="showStatusFilter"
      title="选择核销状态"
      :options="statusOptions"
      :selected-value="selectedStatus"
      @select="selectStatus"
    />

    <!-- 时间筛选弹窗 -->
    <FilterModal
      v-model:visible="showTimeFilter"
      title="选择时间范围"
      :options="timeOptions"
      :selected-value="selectedTimeRange"
      @select="selectTimeRange"
    />
  </view>
  <VerificationCodeQR v-model:show="qrShow" :text="qrText" />
</template>

<style lang="scss" scoped>
.filter-section {
  display: flex;
  gap: 20rpx;
  padding: 20rpx 0;

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
  }

  .empty-text {
    font-size: 28rpx;
    color: var(--text-tertiary);
  }
}
</style>
