<script setup lang="ts">
import { computed } from 'vue'
import { useMemberStore } from '@/store/member'

interface Props {
  userInfo: {
    nickname: string
    phone: string
    avatar: string
    memberExpireDate: string
  }
}

const props = defineProps<Props>()
const emit = defineEmits<{
  modifyNickname: []
  renew: []
}>()

const memberStore = useMemberStore()
const isMember = computed(() => memberStore.isMember)

function handleModifyNickname() {
  emit('modifyNickname')
}

function handleRenew() {
  emit('renew')
}
</script>

<template>
  <view class="p-3">
    <view class="mb-6 flex items-center">
      <image :src="userInfo.avatar" class="mr-4 h-20 w-20 rounded-full" />
      <view class="flex flex-1 items-center justify-between">
        <view class="mb-3 flex flex-col">
          <text class="text-lg text-gray-800 font-bold">{{ userInfo.nickname }}</text>
          <text class="text-sm text-gray-500">{{ userInfo.phone }}</text>
        </view>
        <view class="rounded bg-blue-500 px-4 py-2 text-sm text-white" @click="handleModifyNickname">
          <text class="mr-2">✏️</text>
          <text>修改</text>
        </view>
      </view>
    </view>

    <!-- VIP状态 -->
    <view v-if="isMember" class="flex items-center justify-between rounded-lg bg-black p-5 text-white">
      <view class="grid gap-2">
        <view class="flex items-center">
          <text class="mr-3 text-xl">👑</text>
          <text class="text-base font-bold">尊敬的VIP用户</text>
        </view>
        <view class="text-sm opacity-80">
          您的会员有效期至{{ userInfo.memberExpireDate }}
        </view>
      </view>
      <view class="rounded bg-orange-500 px-4 py-2 text-sm text-white" @click="handleRenew">
        <text class="mr-2">⭐</text>
        <text>立即续费</text>
      </view>
    </view>

    <!-- 非会员状态 -->
    <view v-else class="relative mt-3 rounded-lg bg-blue-500 p-5 text-white">
      <view class="mb-3 flex items-center">
        <text class="mr-3 text-xl">🔒</text>
        <text class="flex-1 text-base font-bold">开通会员享受更多权益</text>
      </view>
      <view
        class="absolute right-5 top-1/2 transform rounded bg-white px-4 py-2 text-sm text-blue-500 -translate-y-1/2"
        @click="handleRenew"
      >
        <text class="mr-2">🚀</text>
        <text>立即开通</text>
      </view>
    </view>
  </view>
</template>
