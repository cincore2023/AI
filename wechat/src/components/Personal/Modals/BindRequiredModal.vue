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
    :visible="show"
    @update:visible="(value) => emit('update:show', value)"
    position="center"
    :close-on-click-overlay="true"
    :close-on-click-close-icon="true"
    round
    safe-area-inset-bottom
  >
    <view class="w-[80vw] bg-white rounded-lg overflow-hidden">
      <view class="bg-gray-800 text-white p-5 text-center">
        <text class="text-lg font-bold">请绑定销售人</text>
      </view>

      <view class="p-5">
        <text class="text-sm text-gray-700 leading-relaxed text-center block py-4">
          您还未绑定销售人，无法开通会员，请绑定推荐员后重试！
        </text>
      </view>

      <view class="p-5 border-t border-gray-200">
        <view
          class="w-full bg-gray-900 text-white py-3 rounded text-center"
          @click="handleConfirm"
        >
          绑定销售员
        </view>
      </view>
    </view>
  </sar-popup>
</template>
