<script setup lang="ts">
import { bindSalesperson } from '@/api/login'
import { useUserStore } from '@/store/user'

const { getUserInfo } = useUserStore()
const visible = ref(false)

const bindSalesPhone = ref('')

async function handleConfirm() {
  if (bindSalesPhone.value?.length !== 11) {
    return uni.showToast({
      title: '手机号错误',
      icon: 'error',
    })
  }
  const { data } = await bindSalesperson(bindSalesPhone.value)
  if (!data.bindingSuccess) {
    return uni.showToast({
      title: data?.message,
      icon: 'error',
    })
  }
  else {
    await getUserInfo()
    uni.showToast({
      title: '绑定成功',
      icon: 'none',
    })
    onOverlayClick()
  }
}

function onOverlayClick() {
  bindSalesPhone.value = ''
  visible.value = false
}

function handleShow() {
  visible.value = true
}

defineExpose({ show: handleShow })
</script>

<template>
  <sar-popup :visible="visible" @overlay-click="onOverlayClick">
    <view class="w-[90vw] overflow-hidden rounded-2xl bg-white shadow-2xl">
      <!-- 头部区域 -->
      <view class="relative p-6 text-center text-white">
        <view class="absolute inset-0 bg-gray-800"/>
        <view class="relative z-10">
          <view class="mb-3 flex justify-center">
            <view class="h-12 w-12 flex items-center justify-center rounded-full bg-white/20">
              <text class="text-2xl">📞</text>
            </view>
          </view>
          <text class="mb-2 block text-xl font-bold">绑定销售专员</text>
          <text class="text-sm opacity-90">请填写销售专员手机号</text>
        </view>
      </view>

      <!-- 内容区域 -->
      <view class="p-3 pb-0">
        <view class="space-y-5">
          <view class="space-y-2">
            <text class="text-base text-gray-800 font-semibold">销售专员手机号 *</text>
            <view class="relative">
              <sar-input v-model="bindSalesPhone" placeholder="请输入11位手机号码" type="tel" clearable/>
            </view>
          </view>

          <!-- 提示信息 -->
          <view class="border-l-4 border-orange-400 rounded-lg bg-orange-50 p-4">
            <view class="flex items-start space-x-2">
              <text class="text-lg text-orange-500">⚠️</text>
              <view class="flex-1">
                <text class="text-sm text-orange-800 font-medium">重要提醒</text>
                <text class="mt-1 block text-xs text-orange-600">绑定后无法更改，请谨慎操作！</text>
              </view>
            </view>
          </view>
        </view>
      </view>

      <!-- 按钮区域 -->
      <view class="flex gap-3 border-t border-gray-100 p-3">
        <view
          class="flex-1 rounded-xl bg-gray-100 py-4 text-center text-gray-700 transition-all duration-200 active:scale-95"
          @click="onOverlayClick"
        >
          <text class="font-medium">取消</text>
        </view>
        <view
          class="flex-1 rounded-xl bg-gray-900 py-4 text-center text-white transition-all duration-200 active:scale-95"
          @click="handleConfirm"
        >
          <text class="font-medium">确认绑定</text>
        </view>
      </view>
    </view>
  </sar-popup>
</template>
