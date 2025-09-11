<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/store/user'
import EditUserInfoModal from './Modals/EditUserInfoModal.vue'

const emit = defineEmits(['renew'])

const { wechatUser, isMember, isLoggedIn } = storeToRefs(useUserStore())

// 编辑弹框相关
const editUserInfoModalRef = ref()

// 打开编辑弹框
function handleModifyNickname() {
  if (isLoggedIn.value) {
    editUserInfoModalRef.value?.open()
  }
  else {
    uni.navigateTo({
      url: '/pages/login/login',
    })
  }
}

function handleRenew() {
  emit('renew')
}
</script>

<template>
  <view class="p-4 pt-0">
    <view class="mb-6 flex items-center" @click="handleModifyNickname">
      <image v-if="wechatUser?.avatar" :src="wechatUser?.avatar" class="mr-4 h-20 w-20 rounded-full"/>
      <image v-else src="@/static/images/avatar.png" class="mr-4 h-20 w-20 rounded-full" mode="aspectFit"/>
      <view class="flex-1">
        <view class="mb-3 flex items-center justify-between">
          <text class="text-lg text-gray-800 font-bold">{{ isLoggedIn ? wechatUser.nickname : '未登录' }}</text>
        </view>
        <text class="text-sm text-gray-500">{{ wechatUser.phone_number }}</text>
      </view>
    </view>

    <!-- VIP状态 -->
    <view v-if="isMember" class="flex items-center justify-between rounded-lg bg-black p-3 text-white">
      <view class="flex items-center gap-3">
        <text class="text-4">👑</text>
        <view class="grid gap-1">
          <view class="flex items-center">
            <text class="text-base font-bold">尊敬的VIP用户</text>
          </view>
          <view class="text-3 opacity-80">
            您的会员有效期至{{ wechatUser.membershipExpiryDate }}
          </view>
        </view>
      </view>
      <view class="rounded bg-orange-500 px-4 py-2 text-xs text-white" @click="handleRenew">
        <text class="mr-2">⭐</text>
        <text>立即续费</text>
      </view>
    </view>

    <!-- 非会员状态 -->
    <view v-else class="relative mt-3 flex items-center rounded-lg bg-gray-800 p-5 text-white">
      <view class="flex items-center">
        <text class="mr-3 text-xl">👑</text>
        <text class="flex-1 text-base font-bold">开通会员享受更多权益</text>
      </view>
      <view class="absolute right-5 top-1/2 transform rounded bg-white px-4 py-2 text-sm text-blue-500 -translate-y-1/2" @click="handleRenew">
        <text class="mr-2">🚀</text>
        <text>立即开通</text>
      </view>
    </view>

    <!-- 编辑个人信息弹框 -->
    <EditUserInfoModal ref="editUserInfoModalRef" />
  </view>
</template>
