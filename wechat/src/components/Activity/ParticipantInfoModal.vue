<script setup lang="ts">
import { ref } from 'vue'

defineProps<{
  show: boolean
}>()

const emit = defineEmits<{
  (e: 'update:show', value: boolean): void
  (e: 'confirm', name: string, phone: string): void
}>()

const participantName = ref('')
const participantPhone = ref('')

function handleClose() {
  emit('update:show', false)
}

function handleConfirm() {
  if (!participantName.value.trim()) {
    uni.showToast({
      title: '请输入姓名',
      icon: 'none',
    })
    return
  }

  if (!participantPhone.value.trim()) {
    uni.showToast({
      title: '请输入手机号',
      icon: 'none',
    })
    return
  }

  // 简单的手机号验证
  const phoneRegex = /^1[3-9]\d{9}$/
  if (!phoneRegex.test(participantPhone.value)) {
    uni.showToast({
      title: '请输入正确的手机号',
      icon: 'none',
    })
    return
  }

  emit('confirm', participantName.value, participantPhone.value)

  // 清空表单
  participantName.value = ''
  participantPhone.value = ''

  // 关闭弹窗
  handleClose()
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
        <text class="text-lg font-bold">完善报名信息</text>
      </view>

      <view class="p-5">
        <sar-form label-width="120rpx">
          <sar-form-item label="姓名" required>
            <sar-input
              v-model="participantName"
              placeholder="请输入姓名"
              type="text"
            />
          </sar-form-item>

          <sar-form-item label="手机号" required>
            <sar-input
              v-model="participantPhone"
              placeholder="请输入手机号"
              type="number"
            />
          </sar-form-item>
        </sar-form>
      </view>

      <view class="border-t border-gray-200 p-5">
        <view
          class="w-full rounded bg-gray-900 py-3 text-center text-white"
          @click="handleConfirm"
        >
          确认提交
        </view>
      </view>
    </view>
  </sar-popup>
</template>
