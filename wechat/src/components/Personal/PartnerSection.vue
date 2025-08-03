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
  emit('withdraw')
}

function handleIncomeDetails() {
  emit('incomeDetails')
}

function handleGenerateCode() {
  emit('generateCode')
}
</script>

<template>
  <view class="bg-blue-500 text-white p-6 rounded-t-2xl mt-6">
    <view class="mb-6">
      <text class="text-xl font-bold flex items-center">
        <text class="mr-3">👑</text>
        合伙人中心
      </text>
    </view>

    <!-- 收入概览 -->
    <view class="mb-6">
      <view class="grid grid-cols-2 gap-5">
        <view class="bg-white/20 p-5 rounded-lg">
          <view class="flex items-center mb-3">
            <text class="text-lg mr-2">💰</text>
            <text class="text-sm opacity-90">可提现收入</text>
          </view>
          <text class="text-xl font-bold mb-4">¥{{ partnerInfo.withdrawableIncome }}</text>
          <view
            class="w-full bg-red-500 text-white py-3 rounded text-sm text-center"
            @click="handleWithdraw"
          >
            <text class="mr-2">💳</text>
            <text>提现</text>
          </view>
        </view>

        <view class="bg-white/20 p-5 rounded-lg">
          <view class="flex items-center mb-3">
            <text class="text-lg mr-2">📈</text>
            <text class="text-sm opacity-90">累计收入</text>
          </view>
          <text class="text-xl font-bold mb-4">¥{{ partnerInfo.totalIncome }}</text>
          <view
            class="w-full bg-blue-400 text-white py-3 rounded text-sm text-center"
            @click="handleIncomeDetails"
          >
            <text class="mr-2">📊</text>
            <text>收支明细</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 详细统计 -->
    <view class="bg-white text-gray-800 rounded-xl p-6">
      <view class="grid grid-cols-2 gap-5 mb-5">
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">👥</text>
          <text class="text-xs text-gray-600 mb-2 block">我的团队</text>
          <text class="text-lg font-bold">{{ partnerInfo.teamCount }}人</text>
        </view>
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">⏳</text>
          <text class="text-xs text-gray-600 mb-2 block">提现中</text>
          <text class="text-lg font-bold">¥{{ partnerInfo.withdrawing }}</text>
        </view>
      </view>

      <view class="grid grid-cols-2 gap-5 mb-5">
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">🎫</text>
          <text class="text-xs text-gray-600 mb-2 block">推广码</text>
          <view
            class="bg-green-500 text-white px-4 py-2 rounded text-sm text-center mx-auto whitespace-nowrap"
            @click="handleGenerateCode"
          >
            <text>生成推广码</text>
          </view>
        </view>
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">💸</text>
          <text class="text-xs text-gray-600 mb-2 block">已提现</text>
          <text class="text-lg font-bold">¥{{ partnerInfo.withdrawn }}</text>
        </view>
      </view>

      <view class="grid grid-cols-2 gap-5">
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">👑</text>
          <text class="text-xs text-gray-600 mb-2 block">会员兑换码</text>
          <text class="text-lg font-bold">{{ partnerInfo.memberCode }}</text>
        </view>
        <view class="bg-gray-100 rounded-lg p-5 text-center">
          <text class="text-2xl mb-3 block">🎁</text>
          <text class="text-xs text-gray-600 mb-2 block">活动兑换码</text>
          <text class="text-lg font-bold">{{ partnerInfo.activityCode }}</text>
        </view>
      </view>
    </view>
  </view>
</template> 