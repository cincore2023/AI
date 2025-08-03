<script setup lang="ts">
interface Props {
  show: boolean
}

const props = defineProps<Props>()
const emit = defineEmits<{
  'update:show': [value: boolean]
  confirm: []
}>()

function handleConfirm() {
  emit('confirm')
}

function handleClose() {
  emit('update:show', false)
}
</script>

<template>
  <sar-popup
    :show="show"
    @update:show="(value) => emit('update:show', value)"
    position="center"
    :close-on-click-overlay="true"
    :close-on-click-close-icon="true"
    round
    safe-area-inset-bottom
  >
    <view class="w-160 bg-white rounded-lg overflow-hidden">
      <view class="bg-blue-500 text-white p-6 text-center">
        <text class="text-xl font-bold">开通会员</text>
      </view>

      <view class="p-6">
        <!-- 会员卡片 -->
        <view class="bg-gray-800 text-white p-4 rounded-lg mb-6">
          <view class="flex justify-between items-center">
            <view class="flex-1">
              <text class="text-base font-bold block mb-2">鲸抖迅VIP会员年卡</text>
            </view>
            <view class="text-right">
              <text class="text-2xl font-bold text-yellow-400 block mb-1">399元/年</text>
              <text class="text-xs opacity-80">折合: 1.09元/天</text>
            </view>
          </view>
        </view>

        <!-- VIP权益 -->
        <view class="mb-6">
          <text class="text-base font-bold text-gray-800 block mb-4">VIP权益</text>
          <view class="space-y-3">
            <view class="flex items-start gap-3">
              <text class="text-blue-500 font-bold min-w-6">1.</text>
              <text class="text-sm text-gray-600 flex-1">免费学习全站所有课程。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="text-blue-500 font-bold min-w-6">2.</text>
              <text class="text-sm text-gray-600 flex-1">免费下载素材库所有资料。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="text-blue-500 font-bold min-w-6">3.</text>
              <text class="text-sm text-gray-600 flex-1">免费使用基础智能体。</text>
            </view>
            <view class="flex items-start gap-3">
              <text class="text-blue-500 font-bold min-w-6">4.</text>
              <text class="text-sm text-gray-600 flex-1">升级成为合伙人，销售享提成。</text>
            </view>
          </view>
        </view>
      </view>

      <view class="p-6 border-t border-gray-200">
        <view
          class="w-full bg-blue-500 text-white py-3 rounded text-center"
          @click="handleConfirm"
        >
          确认开通并支付
        </view>
      </view>
    </view>
  </sar-popup>
</template> 