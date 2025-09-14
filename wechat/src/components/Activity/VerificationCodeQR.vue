<script setup lang="ts">
import Qrcode from 'sard-uniapp/components/qrcode/qrcode.vue'

defineProps<{
  show: boolean
  text: string
}>()

const emit = defineEmits<{
  (e: 'update:show', value: boolean): void
}>()

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
        <text class="text-lg font-bold">核销码</text>
      </view>

      <view class="flex flex-col items-center justify-center">
        <Qrcode :text="text" />
        <text class="verification-code-text">{{ text }}</text>
      </view>

      <view class="border-t border-gray-200 p-5">
        <view
          class="w-full rounded bg-gray-900 py-3 text-center text-white"
          @click="handleClose"
        >
          确认
        </view>
      </view>
    </view>
  </sar-popup>
</template>
