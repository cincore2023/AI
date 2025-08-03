<script setup lang="ts">
interface Props {
  show: boolean
  bindSalesPhone: string
}

const props = defineProps<Props>()
const emit = defineEmits<{
  'update:show': [value: boolean]
  'update:bindSalesPhone': [value: string]
  'confirm': []
  'cancel': []
}>()

function handleConfirm() {
  emit('confirm')
}

function handleCancel() {
  emit('cancel')
}

function handleClose() {
  emit('update:show', false)
}
</script>

<template>
  <sar-popup
    :visible="show"
    :close-on-click-close-icon="true"
    position="center"
    :close-on-click-overlay="true"
    round
    safe-area-inset-bottom
    @update:visible="(value) => emit('update:show', value)"
  >
    <view class="w-[90vw] overflow-hidden rounded-2xl bg-white shadow-2xl">
      <!-- 头部区域 -->
      <view class="relative p-6 text-center text-white">
        <view class="absolute inset-0 bg-gray-600" />
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
              <sar-input
                :model-value="bindSalesPhone"
                placeholder="请输入11位手机号码"
                type="number"
                maxlength="11"
                clearable
                class="w-full border-2 border-gray-200 rounded-lg px-4 py-3 text-base focus:border-blue-500"
                @update:model-value="(value) => emit('update:bindSalesPhone', value)"
              />
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
          @click="handleCancel"
        >
          <text class="font-medium">取消</text>
        </view>
        <view
          class="bg-gray-900 flex-1 rounded-xl py-4 text-center text-white transition-all duration-200 active:scale-95"
          @click="handleConfirm"
        >
          <text class="font-medium">确认绑定</text>
        </view>
      </view>
    </view>
  </sar-popup>
</template>