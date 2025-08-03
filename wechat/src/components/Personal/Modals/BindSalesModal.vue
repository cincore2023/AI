<script setup lang="ts">
interface Props {
  show: boolean
  bindSalesPhone: string
}

const props = defineProps<Props>()
const emit = defineEmits<{
  'update:show': [value: boolean]
  'update:bindSalesPhone': [value: string]
  confirm: []
  cancel: []
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
    :show="show"
    @update:show="(value) => emit('update:show', value)"
    position="center"
    :close-on-click-overlay="true"
    :close-on-click-close-icon="true"
    round
    safe-area-inset-bottom
  >
    <view class="w-150 bg-white rounded-lg overflow-hidden">
      <view class="bg-blue-500 text-white p-6 text-center">
        <text class="text-xl font-bold block mb-2">绑定销售专员</text>
        <text class="text-sm opacity-80">请填写销售专员手机号</text>
      </view>

      <view class="p-6">
        <view class="space-y-3">
          <text class="text-base font-bold text-gray-800">销售专员手机号 *</text>
          <sar-input
            :model-value="bindSalesPhone"
            @update:model-value="(value) => emit('update:bindSalesPhone', value)"
            placeholder="请填写销售专员手机号"
            type="number"
            maxlength="11"
            clearable
            class="w-full"
          />
          <text class="text-xs text-red-500">绑定后无法更改，请谨慎操作！</text>
        </view>
      </view>

      <view class="flex gap-4 p-6 border-t border-gray-200">
        <view
          class="flex-1 bg-gray-400 text-white py-3 rounded text-center"
          @click="handleCancel"
        >
          取消
        </view>
        <view
          class="flex-1 bg-blue-500 text-white py-3 rounded text-center"
          @click="handleConfirm"
        >
          确认绑定
        </view>
      </view>
    </view>
  </sar-popup>
</template> 