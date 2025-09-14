<route lang="jsonc" type="page">
{
"layout": "defaultV2",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "活动详情"
}
}
</route>

<script setup lang="ts">
import type { WxActivityDetailItem } from '@/api/types/activity'
import dayjs from 'dayjs'
import { ref } from 'vue'
import { getWxActivityDetail } from '@/api/activity'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import HomeSwiper from '@/components/Home/HomeSwiper.vue'
import { useUserStore } from '@/store'
import {storeToRefs} from 'pinia'

const activityId = ref('')
const activityDetail = ref<WxActivityDetailItem | null>(null)
const loading = ref(false)
const userStore = useUserStore()
const { wechatUser } = storeToRefs(userStore)
const showScanButton = computed(() => {
  return Number(activityDetail.value?.salesperson) === Number(wechatUser.value.ID)
})

// 获取活动详情
async function getActivityDetail(id: string) {
  loading.value = true
  try {
    const { data } = await getWxActivityDetail(id)
    activityDetail.value = data
    console.log('活动详情获取成功:', data)
  }
  catch (error) {
    console.error('获取活动详情失败:', error)
    uni.showToast({
      title: '获取活动详情失败',
      icon: 'error',
    })
  }
  finally {
    loading.value = false
  }
}

// 扫描二维码
function handleScan() {
  uni.scanCode({
    onlyFromCamera: true,
    scanType: ['qrCode'],
    success(res) {
      console.log('扫描结果:', res)
      // 这里添加核销逻辑
      uni.showToast({
        title: '核销成功',
        icon: 'success',
      })
    },
    fail(err) {
      console.error('扫描失败:', err)
      uni.showToast({
        title: '扫描失败',
        icon: 'none',
      })
    },
  })
}

// 报名活动
function handleSignUp() {
  uni.showToast({
    title: '报名成功',
    icon: 'success',
  })
}

// 回到首页
function goHome() {
  uni.switchTab({
    url: '/pages/index/index',
  })
}

// 分享功能
function shareActivity() {
  // #ifdef MP-WEIXIN
  uni.showShareMenu({
    withShareTicket: true,
    menus: ['shareAppMessage', 'shareTimeline'],
  })
  // #endif

  // #ifndef MP-WEIXIN
  uni.showToast({
    title: '分享功能仅在微信小程序中可用',
    icon: 'none',
  })
  // #endif
}

const systemInfo = uni.getWindowInfo()

const countdownData = computed(() => {
  if (!activityDetail.value?.startTime)
    return 0

  const endTime = dayjs(activityDetail.value.startTime)
  const now = dayjs()
  const diff = endTime.diff(now, 'second')
  return diff * 1000
})

const BottomStyle = computed(() => ({
  paddingBottom: `${systemInfo.windowHeight - systemInfo.safeArea.bottom + 5}px` || '0px',
  paddingTop: '20rpx',
}))

onMounted(async () => {
  // 获取最新用户信息
  await userStore.getUserInfo()
})

onLoad((options) => {
  if (options?.id) {
    activityId.value = options.id
    getActivityDetail(options.id)
  }
})

// 微信小程序分享功能
// #ifdef MP-WEIXIN
onShareAppMessage((res) => {
  if (res.from === 'button') {
    console.log('来自页面内转发按钮')
  }

  return {
    title: activityDetail.value?.activityName || '推荐一个活动',
    path: `/pages/activities/detail?id=${activityId.value}`,
    imageUrl: activityDetail.value?.coverPicture || '',
  }
})

onShareTimeline(() => {
  return {
    title: activityDetail.value?.activityName || '推荐一个活动',
    imageUrl: activityDetail.value?.coverPicture || '',
  }
})
// #endif
</script>

<template>
  <view class="h-[100vh] flex flex-col overflow-hidden">
    <!-- 头部 -->
    <HeaderSimple title="活动详情" :show-back="true" class="px-[30rpx]" />

    <scroll-view
      class="no-scrollbar flex flex-1 flex-col"
      :scroll-y="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <view class="px-[30rpx]">
        <!-- 活动图片轮播 -->
        <HomeSwiper :images="[activityDetail?.coverPicture]" class="mt-[30rpx]" />

        <!-- 活动基本信息 -->
        <view class="py-4 pb-0">
          <!-- 价格信息 -->
          <view class="price-section flex items-center justify-between">
            <view class="price-info">
              <text class="price-label">价格:</text>
              <text class="price-value">¥{{ activityDetail?.price }}</text>
            </view>
            <view class="activity-stats">
              已报名: {{ activityDetail?.actualEnrollment || 0 }}人
            </view>
          </view>

          <view class="activity-title">
            {{ activityDetail?.activityName }}
          </view>

          <!-- 活动说明 -->
          <view v-if="countdownData" class="activity-notice">
            <view class="notice-content">
              <text class="notice-icon">距报名结束</text>
              <sar-count-down :time="countdownData" format="DD 天 HH 时 mm 分 ss 秒" />
            </view>
          </view>
        </view>

        <!-- 活动内容 -->
        <view class="mb-[40rpx]">
          <view class="mb-[20rpx] text-[32rpx] text-[#333] font-bold">
            详情
          </view>
          <view class="activity-details-content">
            <rich-text v-if="activityDetail?.details" :nodes="activityDetail.details" />
            <view v-else class="empty-details">
              暂无详情内容
            </view>
          </view>
        </view>
      </view>
    </scroll-view>

    <!-- 底部操作栏 -->
    <view class="bottom-actions" :style="BottomStyle">
      <view class="action-buttons">
        <sar-button type="text" @click="goHome">
          <view class="action-btn">
            <view class="action-icon">
              🏠
            </view>
            <view class="action-text">
              首页
            </view>
          </view>
        </sar-button>
        <sar-button type="text" open-type="share" @click="shareActivity">
          <view class="action-btn">
            <view class="action-icon">
              📤
            </view>
            <view class="action-text">
              分享
            </view>
          </view>
        </sar-button>
      </view>
      <view class="flex flex-1 gap-2">
        <sar-button
          class="main-action-btn"
          round
          block
          theme="secondary"
          @click="handleSignUp"
        >
          立即报名
        </sar-button>
        <sar-button
          v-if="showScanButton"
          class="scan-btn"
          round
          block
          theme="secondary"
          @click="handleScan"
        >
          <sar-icon name="scan" size="20" />
          扫描核销
        </sar-button>
      </view>
    </view>
  </view>
</template>

<style scoped lang="scss">
.activity-title {
  font-size: 36rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-sm);
  line-height: 1.4;
}

.activity-stats {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-section {
  margin-bottom: var(--spacing-md);
}

.price-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

.price-label {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.price-value {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--error-color);
}

.activity-notice {
  padding: var(--spacing-md);
  border-radius: var(--radius-md);
  margin-bottom: var(--spacing-md);
  background: rgba(250, 173, 20, 0.1);
  border: 1px solid rgba(250, 173, 20, 0.3);
}

.notice-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.notice-icon {
  font-size: 32rpx;
  margin-right: var(--spacing-sm);
  color: var(--warning-color);
}

.notice-text {
  flex: 1;
  font-size: 26rpx;
  color: var(--text-primary);
}

.countdown-container {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.countdown-box {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 60rpx;
  height: 60rpx;
  background-color: var(--sar-primary);
  color: #fff;
  border-radius: var(--sar-rounded);
  font-size: 28rpx;
}

.countdown-colon {
  margin: 0 10rpx;
  color: var(--text-primary);
  font-size: 28rpx;
}

.activity-info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 30rpx;
  background: var(--bg-tertiary);
  padding: 30rpx;
  border-radius: 16rpx;
}

.activity-details-content {
  padding: 20rpx;
  background: var(--bg-tertiary);
  border-radius: 16rpx;
  font-size: 28rpx;
  line-height: 1.6;
  color: var(--text-primary);
}

.empty-details {
  color: var(--text-tertiary);
  text-align: center;
  padding: 40rpx 0;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 10rpx;
}

.info-label {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.info-value {
  font-size: 26rpx;
  color: var(--text-primary);
  font-weight: 500;
}

/* 底部操作栏样式 */
.bottom-actions {
  background: var(--bg-primary);
  display: flex;
  align-items: center;
  gap: 26px;
  padding: 32rpx;
  box-shadow: var(--shadow-lg);
}

.action-buttons {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
}

.action-btn {
  flex: 1;
  padding: var(--spacing-sm) 0;
  text-align: center;
  color: var(--bg-inverse);
}

.action-icon {
  font-size: 32rpx;
  margin-bottom: var(--spacing-xs);
}

.action-text {
  font-size: 22rpx;
}

.main-action-btn {
  width: 100%;
  font-size: 26rpx;
  font-weight: bold;
  border: none;
  color: var(--text-primary);
  background-color: var(--bg-inverse);
  margin-bottom: 20rpx;
}

.scan-btn {
  width: 100%;
  font-size: 26rpx;
  font-weight: bold;
}
</style>
