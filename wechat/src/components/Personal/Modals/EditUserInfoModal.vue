<script setup lang="ts">
interface Props {
  show: boolean
}

defineProps<Props>()
const emit = defineEmits<{ 'update:show': [value: boolean] }>()

// 编辑表单
const editForm = ref({
  nickname: '',
  phone: '',
  avatar: '',
})

// 确认编辑
function handleConfirmEdit() {

}

// 取消编辑
function handleCancelEdit() {
  emit('update:show', false)
}

// 选择头像
function handleSelectAvatar() {
  uni.chooseImage({
    count: 1,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      editForm.value.avatar = res.tempFilePaths[0]
    }
  })
}
</script>

<template>
  <sar-popup :visible="show" effect="zoom" @update:visible="(value) => emit('update:show', value)">
    <view class="w-[90vw] overflow-hidden rounded-2xl bg-white shadow-2xl">
      <!-- 头部区域 -->
      <view class="relative p-6 text-center text-white">
        <view class="absolute inset-0 bg-gray-800"/>
        <view class="relative z-10">
          <view class="mb-3 flex justify-center">
            <view class="h-12 w-12 flex items-center justify-center rounded-full bg-white/20">
              <text class="text-2xl">👤</text>
            </view>
          </view>
          <text class="mb-2 block text-xl font-bold">编辑个人信息</text>
          <text class="text-sm opacity-90">修改您的头像、昵称和手机号</text>
        </view>
      </view>

      <!-- 内容区域 -->
      <view class="p-6">
        <view class="space-y-6">
          <!-- 头像 -->
          <view class="space-y-3">
            <text class="text-base text-gray-800 font-semibold">头像</text>
            <view class="flex justify-center">
              <view class="relative">
                <image
                    :src="editForm.avatar"
                    class="h-20 w-20 rounded-full border-2 border-gray-200"
                />
                <view
                    class="absolute -bottom-1 -right-1 flex h-6 w-6 items-center justify-center rounded-full bg-blue-500 text-white"
                    @click="handleSelectAvatar"
                >
                  <text class="text-xs">📷</text>
                </view>
              </view>
            </view>
          </view>

          <!-- 昵称 -->
          <view class="space-y-2">
            <text class="text-base text-gray-800 font-semibold">昵称 *</text>
            <sar-input
                v-model="editForm.nickname"
                placeholder="请输入昵称"
                class="w-full border-2 border-gray-200 rounded-lg px-4 py-3 text-base focus:border-blue-500"
            />
          </view>

          <!-- 手机号 -->
          <view class="space-y-2">
            <text class="text-base text-gray-800 font-semibold">手机号</text>
            <sar-input
                v-model="editForm.phone"
                placeholder="请输入手机号"
                type="number"
                maxlength="11"
                class="w-full border-2 border-gray-200 rounded-lg px-4 py-3 text-base focus:border-blue-500"
            />
          </view>
        </view>
      </view>

      <!-- 按钮区域 -->
      <view class="flex gap-3 border-t border-gray-100 p-6">
        <view
            class="flex-1 rounded-xl bg-gray-100 py-4 text-center text-gray-700 transition-all duration-200 active:scale-95"
            @click="handleCancelEdit"
        >
          <text class="font-medium">取消</text>
        </view>
        <view
            class="bg-gray-900 flex-1 rounded-xl py-4 text-center text-white transition-all duration-200 active:scale-95"
            @click="handleConfirmEdit"
        >
          <text class="font-medium">确认修改</text>
        </view>
      </view>
    </view>
  </sar-popup>
</template> 