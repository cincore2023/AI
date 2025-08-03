<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useMemberStore } from '@/store/member'

interface ServiceItem {
  icon: string
  title: string
  path: string
}

interface PartnerInfo {
  withdrawableIncome: number
  totalIncome: number
  teamCount: number
  withdrawing: number
  withdrawn: number
  memberCode: number
  activityCode: number
}

const memberStore = useMemberStore()
const isMember = computed(() => memberStore.isMember)

// 我的服务列表
const serviceList = ref<ServiceItem[]>([
  { icon: '📊', title: '我的活动', path: '/pages/activity/index' },
  { icon: '📚', title: '我的课程', path: '/pages/course/index' },
  { icon: '📁', title: '我的素材', path: '/pages/material/index' },
  { icon: '🤖', title: '我的智能体', path: '/pages/ai/index' },
  { icon: '🎧', title: '联系客服', path: '/pages/service/index' },
  { icon: '📖', title: '教程中心', path: '/pages/tutorial/index' },
])

// 合伙人信息
const partnerInfo = ref<PartnerInfo>({
  withdrawableIncome: 1000.20,
  totalIncome: 1000.20,
  teamCount: 1200,
  withdrawing: 1200,
  withdrawn: 1800,
  memberCode: 99,
  activityCode: 5,
})

// 用户信息
const userInfo = ref({
  nickname: '微信昵称',
  phone: '185****0617',
  avatar: '/static/images/avatar.jpg',
  memberExpireDate: '2021-12-12',
})

// 处理服务点击
function handleServiceClick(service: ServiceItem) {
  uni.navigateTo({
    url: service.path,
  })
}

// 修改昵称
function handleModifyNickname() {
  uni.showModal({
    title: '修改昵称',
    content: '请输入新的昵称',
    editable: true,
    success: (res) => {
      if (res.confirm && res.content) {
        userInfo.value.nickname = res.content
        uni.showToast({
          title: '修改成功',
          icon: 'success',
        })
      }
    },
  })
}

// 立即续费
function handleRenew() {
  uni.showModal({
    title: '续费会员',
    content: '是否立即续费会员？',
    success: (res) => {
      if (res.confirm) {
        memberStore.activateMember()
      }
    },
  })
}

// 绑定销售专员
function handleBindSales() {
  uni.showModal({
    title: '绑定销售专员',
    content: '请输入销售专员编号',
    editable: true,
    success: (res) => {
      if (res.confirm && res.content) {
        uni.showToast({
          title: '绑定成功',
          icon: 'success',
        })
      }
    },
  })
}

// 提现
function handleWithdraw() {
  uni.showModal({
    title: '提现',
    content: `确认提现 ${partnerInfo.value.withdrawableIncome} 元？`,
    success: (res) => {
      if (res.confirm) {
        uni.showToast({
          title: '提现申请已提交',
          icon: 'success',
        })
      }
    },
  })
}

// 收支明细
function handleIncomeDetails() {
  uni.navigateTo({
    url: '/pages/partner/income',
  })
}

// 生成推广码
function handleGenerateCode() {
  uni.showToast({
    title: '推广码已生成',
    icon: 'success',
  })
}

onMounted(async () => {
  // 检查会员状态
  await memberStore.checkMemberStatus()
})
</script>

<template>
  <view class="personal-center">
    <!-- 头部 -->
    <HeaderSimple
      title="个人中心"
      :show-back="false"
      :show-right="true"
    />

    <!-- 用户信息区域 -->
    <view class="user-info-section">
      <view class="user-info">
        <image :src="userInfo.avatar" class="user-avatar" />
        <view class="user-details">
          <view class="nickname-row">
            <text class="nickname">{{ userInfo.nickname }}</text>
            <button class="modify-btn" @click="handleModifyNickname">修改</button>
          </view>
          <text class="phone">{{ userInfo.phone }}</text>
        </view>
      </view>

      <!-- VIP状态 -->
      <view v-if="isMember" class="vip-banner">
        <view class="vip-content">
          <text class="vip-icon">👑</text>
          <text class="vip-text">尊敬的VIP用户</text>
        </view>
        <view class="vip-expire">
          您的会员有效期至{{ userInfo.memberExpireDate }}
        </view>
        <button class="renew-btn" @click="handleRenew">立即续费</button>
      </view>
    </view>

    <!-- 我的服务 -->
    <view class="service-section">
      <view class="section-header">
        <text class="section-title">我的服务</text>
        <view class="sales-bind">
          <text class="sales-label">销售专员:</text>
          <button class="bind-btn" @click="handleBindSales">立即绑定</button>
        </view>
      </view>

      <view class="service-grid">
        <view
          v-for="(service, index) in serviceList"
          :key="index"
          class="service-item"
          @click="handleServiceClick(service)"
        >
          <view class="service-icon">{{ service.icon }}</view>
          <text class="service-title">{{ service.title }}</text>
        </view>
      </view>
    </view>

    <!-- 合伙人中心 -->
    <view class="partner-section">
      <view class="partner-header">
        <text class="partner-title">合伙人中心</text>
      </view>

      <!-- 收入概览 -->
      <view class="income-overview">
        <view class="income-item">
          <view class="income-info">
            <text class="income-label">可提现收入</text>
            <text class="income-amount">¥{{ partnerInfo.withdrawableIncome }}</text>
          </view>
          <button class="withdraw-btn" @click="handleWithdraw">提现</button>
        </view>

        <view class="income-item">
          <view class="income-info">
            <text class="income-label">累计收入</text>
            <text class="income-amount">¥{{ partnerInfo.totalIncome }}</text>
          </view>
          <button class="details-btn" @click="handleIncomeDetails">收支明细</button>
        </view>
      </view>

      <!-- 详细统计 -->
      <view class="partner-stats">
        <view class="stat-row">
          <view class="stat-item">
            <text class="stat-label">我的团队</text>
            <text class="stat-value">{{ partnerInfo.teamCount }}人</text>
          </view>
          <view class="stat-item">
            <text class="stat-label">提现中</text>
            <text class="stat-value">¥{{ partnerInfo.withdrawing }}</text>
          </view>
        </view>

        <view class="stat-row">
          <view class="stat-item">
            <text class="stat-label">推广码</text>
            <button class="code-btn" @click="handleGenerateCode">生成推广码</button>
          </view>
          <view class="stat-item">
            <text class="stat-label">已提现</text>
            <text class="stat-value">¥{{ partnerInfo.withdrawn }}</text>
          </view>
        </view>

        <view class="stat-row">
          <view class="stat-item">
            <text class="stat-label">会员兑换码</text>
            <text class="stat-value">{{ partnerInfo.memberCode }}</text>
          </view>
          <view class="stat-item">
            <text class="stat-label">活动兑换码</text>
            <text class="stat-value">{{ partnerInfo.activityCode }}</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<route lang="jsonc" type="home">
{
  "layout": "tabbar",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "个人中心"
  }
}
</route>

<style lang="scss" scoped>
.personal-center {
  min-height: 100vh;
  background-color: var(--bg-secondary);
}

.user-info-section {
  background-color: var(--bg-primary);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
}

.user-info {
  display: flex;
  align-items: center;
  margin-bottom: var(--spacing-md);
}

.user-avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  margin-right: var(--spacing-md);
}

.user-details {
  flex: 1;
}

.nickname-row {
  display: flex;
  align-items: center;
  margin-bottom: var(--spacing-xs);
}

.nickname {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-right: var(--spacing-sm);
}

.modify-btn {
  font-size: 22rpx;
  color: var(--text-tertiary);
  background: none;
  border: 1px solid var(--border-primary);
  border-radius: var(--radius-sm);
  padding: 4rpx 12rpx;
}

.phone {
  font-size: 26rpx;
  color: var(--text-secondary);
}

.vip-banner {
  background: var(--text-primary);
  color: var(--text-inverse);
  padding: var(--spacing-md);
  border-radius: var(--radius-md);
  position: relative;
}

.vip-content {
  display: flex;
  align-items: center;
  margin-bottom: var(--spacing-xs);
}

.vip-icon {
  font-size: 32rpx;
  margin-right: var(--spacing-sm);
}

.vip-text {
  font-size: 28rpx;
  font-weight: bold;
}

.vip-expire {
  font-size: 24rpx;
  opacity: 0.8;
  margin-bottom: var(--spacing-sm);
}

.renew-btn {
  position: absolute;
  right: var(--spacing-md);
  top: 50%;
  transform: translateY(-50%);
  background: var(--text-inverse);
  color: var(--text-primary);
  border: 1px solid var(--text-primary);
  border-radius: var(--radius-sm);
  padding: var(--spacing-xs) var(--spacing-sm);
  font-size: 24rpx;
}

.service-section {
  background-color: var(--bg-primary);
  padding: var(--spacing-md);
  margin-bottom: var(--spacing-md);
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--spacing-md);
}

.section-title {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.sales-bind {
  display: flex;
  align-items: center;
}

.sales-label {
  font-size: 24rpx;
  color: var(--text-secondary);
  margin-right: var(--spacing-sm);
}

.bind-btn {
  font-size: 22rpx;
  color: var(--primary-color);
  background: none;
  border: 1px solid var(--primary-color);
  border-radius: var(--radius-sm);
  padding: 4rpx 12rpx;
}

.service-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--spacing-md);
}

.service-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: var(--spacing-md);
  background: var(--bg-secondary);
  border-radius: var(--radius-md);
}

.service-icon {
  font-size: 48rpx;
  margin-bottom: var(--spacing-sm);
}

.service-title {
  font-size: 24rpx;
  color: var(--text-primary);
  text-align: center;
}

.partner-section {
  background: var(--text-primary);
  color: var(--text-inverse);
  padding: var(--spacing-md);
}

.partner-header {
  margin-bottom: var(--spacing-md);
}

.partner-title {
  font-size: 32rpx;
  font-weight: bold;
}

.income-overview {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
  margin-bottom: var(--spacing-lg);
}

.income-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--spacing-md);
  background: rgba(255, 255, 255, 0.1);
  border-radius: var(--radius-md);
}

.income-info {
  display: flex;
  flex-direction: column;
}

.income-label {
  font-size: 24rpx;
  opacity: 0.8;
  margin-bottom: var(--spacing-xs);
}

.income-amount {
  font-size: 32rpx;
  font-weight: bold;
}

.withdraw-btn,
.details-btn {
  background: var(--text-inverse);
  color: var(--text-primary);
  border: none;
  border-radius: var(--radius-sm);
  padding: var(--spacing-xs) var(--spacing-md);
  font-size: 24rpx;
}

.partner-stats {
  background: var(--text-inverse);
  color: var(--text-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
}

.stat-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: var(--spacing-md);

  &:last-child {
    margin-bottom: 0;
  }
}

.stat-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-label {
  font-size: 24rpx;
  color: var(--text-secondary);
  margin-bottom: var(--spacing-xs);
}

.stat-value {
  font-size: 28rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.code-btn {
  background: var(--primary-color);
  color: var(--text-inverse);
  border: none;
  border-radius: var(--radius-sm);
  padding: var(--spacing-xs) var(--spacing-sm);
  font-size: 22rpx;
}
</style> 