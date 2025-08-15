<script setup lang="ts">
interface PartnerInfo {
  withdrawableIncome: number
  totalIncome: number
  teamCount: number
  withdrawing: number
  withdrawn: number
  memberCode: number
  activityCode: number
}

interface Props {
  partnerInfo: PartnerInfo
}

const props = defineProps<Props>()
const emit = defineEmits<{
  withdraw: []
  incomeDetails: []
  generateCode: []
}>()

function handleWithdraw() {
  uni.navigateTo({url: '/pages/withdrawal/index'})
}

function handleIncomeDetails() {
  // 跳转到收支明细页面
  uni.navigateTo({
    url: '/pages/finance/transactions',
  })
}

function handleMyTeam() {
  // 跳转到收支明细页面
  uni.navigateTo({
    url: '/pages/finance/team',
  })
}

function handleGenerateCode() {
  emit('generateCode')
}
</script>

<template>
  <view class="mt-6 rounded-t-2xl bg-gray-800 p-6 text-white">
    <view class="mb-6">
      <text class="flex items-center text-xl font-bold">
        <text class="mr-3">👑</text>
        合伙人中心
      </text>
    </view>

    <!-- 收入概览 -->
    <view class="mb-6">
      <view class="grid grid-cols-2 gap-5">
        <view class="rounded-lg bg-white/20 p-5">
          <view class="mb-3 flex items-center">
            <text class="mr-2 text-lg">💰</text>
            <text class="text-sm opacity-90">可提现收入</text>
          </view>
          <text class="mb-4 text-xl font-bold">¥{{ partnerInfo.withdrawableIncome }}</text>
          <view
              class="w-full rounded bg-red-500 py-3 text-center text-sm text-white"
              @click="handleWithdraw"
          >
            <text class="mr-2">💳</text>
            <text>提现</text>
          </view>
        </view>

        <view class="rounded-lg bg-white/20 p-5">
          <view class="mb-3 flex items-center">
            <text class="mr-2 text-lg">📈</text>
            <text class="text-sm opacity-90">累计收入</text>
          </view>
          <text class="mb-4 text-xl font-bold">¥{{ partnerInfo.totalIncome }}</text>
          <view
              class="w-full rounded bg-blue-400 py-3 text-center text-sm text-white"
              @click="handleIncomeDetails"
          >
            <text class="mr-2">📊</text>
            <text>收支明细</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 详细统计 -->
    <view class="rounded-xl bg-white p-6 text-gray-800">
      <view class="grid grid-cols-2 mb-5 gap-5">
        <view class="rounded-lg bg-gray-100 p-5 text-center" @click="handleMyTeam">
          <text class="mb-3 block text-2xl">👥</text>
          <text class="mb-2 block text-xs text-gray-600">我的团队</text>
          <text class="text-lg font-bold">{{ partnerInfo.teamCount }}人</text>
        </view>
        <view
            class="rounded-lg bg-gray-100 p-5 text-center"
            @click="uni.navigateTo({ url: '/pages/finance/balance' })">
          <text class="mb-3 block text-2xl">⏳</text>
          <text class="mb-2 block text-xs text-gray-600">提现中</text>
          <text class="text-lg font-bold">¥{{ partnerInfo.withdrawing }}</text>
        </view>
      </view>

      <view class="grid grid-cols-2 mb-5 gap-5">
        <view class="rounded-lg bg-gray-100 p-5 text-center">
          <text class="mb-3 block text-2xl">🎫</text>
          <text class="mb-2 block text-xs text-gray-600">推广码</text>
          <view
              class="mx-auto whitespace-nowrap rounded bg-green-500 px-4 py-2 text-center text-sm text-white"
              @click="handleGenerateCode"
          >
            <text>生成推广码</text>
          </view>
        </view>
        <view class="rounded-lg bg-gray-100 p-5 text-center">
          <text class="mb-3 block text-2xl">💸</text>
          <text class="mb-2 block text-xs text-gray-600">已提现</text>
          <text class="text-lg font-bold">¥{{ partnerInfo.withdrawn }}</text>
        </view>
      </view>

      <view class="grid grid-cols-2 gap-5">
        <view class="rounded-lg bg-gray-100 p-5 text-center">
          <text class="mb-3 block text-2xl">👑</text>
          <text class="mb-2 block text-xs text-gray-600">会员兑换码</text>
          <text class="text-lg font-bold">{{ partnerInfo.memberCode }}</text>
        </view>
        <view class="rounded-lg bg-gray-100 p-5 text-center">
          <text class="mb-3 block text-2xl">🎁</text>
          <text class="mb-2 block text-xs text-gray-600">活动兑换码</text>
          <text class="text-lg font-bold">{{ partnerInfo.activityCode }}</text>
        </view>
      </view>
    </view>
  </view>
</template>
