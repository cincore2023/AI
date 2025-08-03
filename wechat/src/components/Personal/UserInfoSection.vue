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
  <view class="bg-white p-4 mb-4">
    <view class="flex items-center mb-4">
      <image :src="userInfo.avatar" class="w-30 h-30 rounded-full mr-4" />
      <view class="flex-1">
        <view class="flex items-center justify-between mb-2">
          <text class="text-xl font-bold text-gray-800">{{ userInfo.nickname }}</text>
          <view 
            class="bg-blue-500 text-white px-3 py-1 rounded text-sm"
            @click="handleModifyNickname"
          >
            <text class="mr-1">✏️</text>
            <text>修改</text>
          </view>
        </view>
        <text class="text-sm text-gray-500">{{ userInfo.phone }}</text>
      </view>
    </view>

    <!-- VIP状态 -->
    <view v-if="isMember" class="bg-black text-white p-4 rounded-lg relative">
      <view class="flex items-center mb-2">
        <text class="text-xl mr-2">👑</text>
        <text class="text-base font-bold">尊敬的VIP用户</text>
      </view>
      <view class="text-sm opacity-80 mb-3">
        您的会员有效期至{{ userInfo.memberExpireDate }}
      </view>
      <view
        class="absolute right-4 top-1/2 transform -translate-y-1/2 bg-orange-500 text-white px-3 py-1 rounded text-sm"
        @click="handleRenew"
      >
        <text class="mr-1">⭐</text>
        <text>立即续费</text>
      </view>
    </view>

    <!-- 非会员状态 -->
    <view v-else class="bg-blue-500 text-white p-4 rounded-lg relative mt-2">
      <view class="flex items-center mb-2">
        <text class="text-xl mr-2">🔒</text>
        <text class="text-base font-bold flex-1">开通会员享受更多权益</text>
      </view>
      <view
        class="absolute right-4 top-1/2 transform -translate-y-1/2 bg-white text-blue-500 px-3 py-1 rounded text-sm"
        @click="handleRenew"
      >
        <text class="mr-1">🚀</text>
        <text>立即开通</text>
      </view>
    </view>
  </view>
</template> 