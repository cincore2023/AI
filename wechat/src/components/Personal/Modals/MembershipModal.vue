<script setup lang="ts">
interface Props {
  show: boolean
}

const props = defineProps<Props>()
const emit = defineEmits<{
  'update:show': [value: boolean]
  'confirm': []
}>()

function handleConfirm() {
  console.log('handleConfirm')
}

function handleClose() {
  emit('update:show', false)
}
</script>

<template>
  <sar-popup
    :visible="show"
    position="center"
    :close-on-click-overlay="true"
    :close-on-click-close-icon="true"
    round
    safe-area-inset-bottom
    @update:visible="(value) => emit('update:show', value)"
  >
    <view class="w-[85vw] overflow-hidden rounded-lg bg-white">
      <view class="bg-gray-800 p-5 text-center text-white">
        <text class="text-lg font-bold">开通会员</text>
      </view>

      <view class="p-5 pb-0">
        <!-- 会员卡片 -->
        <view class="mb-5 rounded-lg bg-gray-800 p-4 text-white">
          <view class="flex items-center justify-between">
            <view class="flex-1">
              <text class="mb-2 block text-base font-bold">鲸抖迅VIP会员年卡</text>
            </view>
            <view class="text-right">
              <text class="mb-1 block text-xl text-yellow-400 font-bold">399元/年</text>
              <text class="text-xs opacity-80">折合: 1.09元/天</text>
            </view>
          </view>
        </view>

        <!-- VIP权益 -->
        <view>
          <text class="mb-4 block text-base text-gray-800 font-bold">VIP权益</text>
          <view class="space-y-3">
            <view class="flex items-start gap-3">
              <text class="min-w-6 text-blue-500 font-bold">1.</text>
              <text class="flex-1 text-sm text-gray-600">免费学习全站所有课程。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="min-w-6 text-blue-500 font-bold">2.</text>
              <text class="flex-1 text-sm text-gray-600">免费下载素材库所有资料。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="min-w-6 text-blue-500 font-bold">3.</text>
              <text class="flex-1 text-sm text-gray-600">免费使用基础智能体。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="min-w-6 text-blue-500 font-bold">4.</text>
              <text class="flex-1 text-sm text-gray-600">升级成为合伙人，销售享提成。</text>
            </view>
          </view>
        </view>
      </view>

      <view class="border-t border-gray-200 p-5">
        <view
          class="w-full rounded bg-gray-900 py-3 text-center text-white"
          @click="handleConfirm"
        >
          确认开通并支付
        </view>
      </view>
    </view>
  </sar-popup>
</template>
