<script setup lang="ts">
import { computed, ref } from 'vue'
import EditUserInfoModal from './Modals/EditUserInfoModal.vue'

interface UserInfo {
  nickname: string
  phone: string
  avatar: string
  memberExpireDate: string
}

interface Props {
  userInfo: UserInfo
}

const props = defineProps<Props>()
const emit = defineEmits<{
  modifyNickname: []
  renew: []
}>()

// 计算属性
const isMember = computed(() => {
  return props.userInfo.memberExpireDate && props.userInfo.memberExpireDate !== '未开通'
})

// 编辑弹框相关
const showEditModal = ref(false)

// 打开编辑弹框
function handleModifyNickname() {
  showEditModal.value = true
}

// 确认编辑
function handleConfirmEdit(userInfo: any) {
  // 这里可以调用API更新用户信息
  console.log('更新用户信息:', userInfo)

  showEditModal.value = false
  uni.showToast({
    title: '更新成功',
    icon: 'success',
  })
}

// 取消编辑
function handleCancelEdit() {
  showEditModal.value = false
}

function handleRenew() {
  emit('renew')
}
</script>

<template>
  <view class="p-4">
    <view class="mb-6 flex items-center">
      <image :src="userInfo.avatar" class="mr-4 h-20 w-20 rounded-full" />
      <view class="flex-1">
        <view class="mb-3 flex items-center justify-between">
          <text class="text-lg text-gray-800 font-bold">{{ userInfo.nickname }}</text>
          <view
            class="rounded bg-blue-500 px-4 py-2 text-sm text-white"
            @click="handleModifyNickname"
          >
            <text class="mr-2">✏️</text>
            <text>修改</text>
          </view>
        </view>
        <text class="text-sm text-gray-500">{{ userInfo.phone }}</text>
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
      <view class="rounded bg-orange-500 px-4 py-2 text-xs text-white" @click="handleRenew">
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

    <!-- 编辑个人信息弹框 -->
    <EditUserInfoModal
      :show="showEditModal"
      :user-info="userInfo"
      @update:show="(value) => showEditModal = value"
      @confirm="handleConfirmEdit"
      @cancel="handleCancelEdit"
    />
  </view>
</template>
