<route lang="jsonc" type="page">
{
"layout": "default",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "线下活动"
}
}
</route>

<script setup lang="ts">
import type { WxActivityItem } from '@/api/types/activity'
import dayjs from 'dayjs'
import { getWxActivityList } from '@/api/activity'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import { CourseStore } from '@/store/course'
import { formatDate } from '@/utils/tools'

// 活动数据
const activities = ref<WxActivityItem[]>([])
const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(20)
const { category } = CourseStore()

// 筛选状态
const selectedStatus = ref('')

// 筛选选项
const statusOptions = [
  { label: '全部状态', value: '' },
  { label: '报名中', value: 'enrolling' },
  { label: '进行中', value: 'ongoing' },
  { label: '已结束', value: 'ended' },
]

// 筛选后的活动列表
const filteredActivities = computed(() => {
  let result = activities.value

  // 按状态筛选
  if (selectedStatus.value) {
    result = result.filter(activity => getActivityStatus(activity) === selectedStatus.value)
  }

  return result
})

// 根据活动时间判断状态
function getActivityStatus(activity: WxActivityItem) {
  const now = dayjs()
  const showStart = dayjs(activity.showStartTime)
  const showEnd = dayjs(activity.showEndTime)
  const activityStart = dayjs(activity.startTime)
  const activityEnd = dayjs(activity.endTime)

  // 验证所有日期是否有效
  const dates = [showStart, showEnd, activityStart, activityEnd]
  if (dates.some(date => !date.isValid())) {
    return 'enrolling'
  }

  if (now.isBefore(showStart))
    return 'upcoming'
  if (now.isAfter(activityEnd))
    return 'ended'
  if (now.isAfter(activityStart) && now.isBefore(activityEnd))
    return 'ongoing'
  if (now.isAfter(showStart) && now.isBefore(showEnd))
    return 'enrolling'

  return 'enrolling'
}

// 获取状态文本
function getStatusText(activity: WxActivityItem) {
  const status = getActivityStatus(activity)
  switch (status) {
    case 'enrolling':
      return '报名中'
    case 'upcoming':
      return '即将开始'
    case 'ongoing':
      return '进行中'
    case 'ended':
      return '已结束'
    default:
      return '未知'
  }
}

// 获取状态样式
function getStatusClass(activity: WxActivityItem) {
  const status = getActivityStatus(activity)
  switch (status) {
    case 'enrolling':
      return 'status-enrolling'
    case 'upcoming':
      return 'status-upcoming'
    case 'ongoing':
      return 'status-ongoing'
    case 'ended':
      return 'status-ended'
    default:
      return ''
  }
}

// 获取分类名称
function getCategoryName(idx: number | undefined) {
  const categories = category.flatMap(item => item.children)
  return categories.find(item => item.id === idx).categoryName
}

// 查看活动详情
function viewActivityDetail(activity: any) {
  uni.navigateTo({
    url: `/pages/activities/detail?id=${activity.id}`,
  })
}

// 立即报名
function enrollActivity(activity: any) {

}

// 获取活动列表
async function fetchActivities() {
  try {
    loading.value = true
    const response = await getWxActivityList({ page: currentPage.value, pageSize: pageSize.value })

    if (response.code === 0) {
      activities.value = response.data.activities || []
      total.value = response.data.total || 0
      console.log('获取活动列表成功:', activities.value)
    } else {
      uni.showToast({
        title: response.msg || '获取活动列表失败',
        icon: 'none',
      })
    }
  }
  catch (error) {
    console.error('获取活动列表失败:', error)
    uni.showToast({
      title: '网络错误，请重试',
      icon: 'none',
    })
  } finally {
    loading.value = false
  }
}

// 下拉刷新
function onRefresh() {
  currentPage.value = 1
  fetchActivities().finally(() => {
    // 确保刷新状态被重置
    uni.stopPullDownRefresh()
  })
}

onMounted(() => {
  console.log('线下活动页面已加载')
  fetchActivities()
})
</script>

<template>
  <view class="default-layout-content">
    <!-- 头部 -->
    <HeaderSimple title="线下活动" :show-back="true"/>

    <!-- 筛选选项 -->
    <view class="filter-section">
      <view class="filter-container">
        <scroll-view class="filter-scroll" :scroll-x="true" :show-scrollbar="false">
          <view class="filter-tabs">
            <view
              v-for="option in statusOptions"
              :key="option.value"
              class="filter-tab"
              :class="{ active: selectedStatus === option.value }"
              @click="selectedStatus = option.value">{{ option.label }}</view>
          </view>
        </scroll-view>
      </view>
    </view>

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
      :refresher-enabled="true"
      :refresher-triggered="loading"
      @refresherrefresh="onRefresh"
    >
      <!-- 活动列表 -->
      <view class="activities-container">
        <view
          v-for="activity in filteredActivities"
          :key="activity.id"
          class="activity-card"
          @click="viewActivityDetail(activity)"
        >
          <!-- 活动封面 -->
          <view class="activity-cover">
            <image :src="activity.coverPicture" class="cover-image" mode="aspectFill"/>

            <!-- 状态标签 -->
            <view class="status-badge" :class="getStatusClass(activity)">
              {{ getStatusText(activity) }}
            </view>

            <!-- 分类标签 -->
            <view class="tags-container">
              <view class="activity-tag">
                {{ getCategoryName(activity.category) }}
              </view>
            </view>
          </view>

          <!-- 活动信息 -->
          <view class="activity-info p-5">
            <view class="mb-3 flex items-center justify-between">
              <view class="activity-title">
                {{ activity.activityName }}
              </view>
              <view class="current-price">
                ¥{{ activity.price }}
              </view>
            </view>

            <view class="flex justify-between">
              <view class="activity-meta">
                <view class="meta-item">
                  <text class="meta-icon">📅</text>
                  <text class="meta-text">{{ formatDate(activity.startTime) }}&nbsp;-&nbsp;{{ formatDate(activity.endTime) }}
                  </text>
                </view>
                <view class="meta-item">
                  <text class="meta-icon">📊</text>
                  <text class="meta-text">已报名 {{ activity.actualEnrollment || 0 }} 人</text>
                </view>
              </view>

              <!-- 价格和报名 -->
              <view class="action-section">
                <view
                    class="enroll-btn" :class="{ disabled: getActivityStatus(activity) === 'ended' }"
                    @click.stop="enrollActivity(activity)"
                >
                  <text v-if="getActivityStatus(activity) === 'ended'">已结束</text>
                  <text v-else-if="getActivityStatus(activity) === 'upcoming'">即将开始</text>
                  <text v-else>立即报名</text>
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>

      <!-- 空状态 -->
      <view v-if="filteredActivities.length === 0" class="empty-state">
        <view class="empty-icon">
          🎯
        </view>
        <view class="empty-text">
          暂无符合条件的活动
        </view>
        <view class="empty-desc">
          请尝试调整筛选条件
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.filter-section {
  margin-bottom: 20rpx;
}

.filter-container {
  width: 100%;
}

.filter-scroll {
  width: 100%;
  white-space: nowrap;
}

.filter-tabs {
  display: flex;
  gap: 20rpx;
}

.filter-tab {
  flex-shrink: 0;
  padding: 16rpx 32rpx;
  background: #f5f5f5;
  border-radius: 40rpx;
  font-size: 28rpx;
  color: #666;
  transition: all 0.3s ease;

  &.active {
    background: var(--primary-color);
    color: white;
  }
}

.activity-card {
  background: white;
  border-radius: 24rpx;
  margin-bottom: 30rpx;
  overflow: hidden;
  box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;

  &:active {
    transform: scale(0.98);
  }
}

.activity-cover {
  position: relative;
  height: 400rpx;

  .cover-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .status-badge {
    position: absolute;
    top: 20rpx;
    right: 20rpx;
    padding: 8rpx 20rpx;
    border-radius: 20rpx;
    font-size: 24rpx;
    color: white;

    &.status-enrolling {
      background: #4caf50;
    }

    &.status-upcoming {
      background: #ff9800;
    }

    &.status-ongoing {
      background: #2196f3;
    }

    &.status-ended {
      background: #9e9e9e;
    }
  }

  .tags-container {
    position: absolute;
    top: 20rpx;
    left: 20rpx;
    display: flex;
    gap: 10rpx;
  }

  .activity-tag {
    padding: 6rpx 16rpx;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 16rpx;
    font-size: 22rpx;
    color: var(--primary-color);
    font-weight: bold;
  }
}

.activity-title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  line-height: 1.4;
}

.activity-meta {
  display: flex;
  flex-direction: column;
  gap: 12rpx;
  margin-bottom: 20rpx;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 12rpx;
}

.meta-icon {
  font-size: 28rpx;
}

.meta-text {
  font-size: 26rpx;
  color: #666;
}

.instructor-info {
  display: flex;
  align-items: center;
  gap: 12rpx;
  margin-bottom: 20rpx;
}

.instructor-icon {
  font-size: 28rpx;
}

.instructor-name {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

.instructor-title {
  font-size: 24rpx;
  color: #999;
}

.time-info {
  margin-bottom: 24rpx;
}

.time-item {
  display: flex;
  align-items: center;
  margin-bottom: 8rpx;
}

.time-label {
  font-size: 24rpx;
  color: #666;
  margin-right: 8rpx;
  min-width: 120rpx;
}

.time-text {
  font-size: 24rpx;
  color: #333;
  flex: 1;
}

.highlights {
  display: flex;
  flex-wrap: wrap;
  gap: 16rpx;
  margin-bottom: 24rpx;
}

.highlight-item {
  font-size: 24rpx;
  color: var(--primary-color);
  background: rgba(var(--primary-color-rgb), 0.1);
  padding: 8rpx 16rpx;
  border-radius: 16rpx;
}

.enrollment-info {
  margin-bottom: 24rpx;
}

.enrollment-count {
  font-size: 26rpx;
  color: #666;
  margin-bottom: 12rpx;
}

.enrollment-progress {
  height: 8rpx;
  background: #f0f0f0;
  border-radius: 4rpx;
  overflow: hidden;
}

.progress-bar {
  height: 100%;
  background: var(--primary-color);
  transition: width 0.3s ease;
}

.action-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.price-section {
  display: flex;
  align-items: center;
  gap: 16rpx;
}

.current-price {
  font-size: 36rpx;
  font-weight: bold;
  color: #e74c3c;
}

.original-price {
  font-size: 28rpx;
  color: #999;
  text-decoration: line-through;
}

.enroll-btn {
  padding: 20rpx 40rpx;
  background: var(--primary-color);
  color: white;
  border-radius: 40rpx;
  font-size: 28rpx;
  font-weight: bold;
  transition: all 0.3s ease;

  &.disabled {
    background: #ccc;
    color: #999;
  }

  &:not(.disabled):active {
    background: var(--primary-dark);
    transform: scale(0.95);
  }
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120rpx 0;
  text-align: center;
}

.empty-icon {
  font-size: 120rpx;
  margin-bottom: 40rpx;
}

.empty-text {
  font-size: 32rpx;
  color: #666;
  margin-bottom: 16rpx;
}

.empty-desc {
  font-size: 28rpx;
  color: #999;
}
</style>
