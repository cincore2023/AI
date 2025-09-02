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

// 选择头像方式
function handleSelectAvatar() {
  uni.showActionSheet({
    itemList: ['从相册选择', '使用微信头像'],
    success: (res) => {
      if (res.tapIndex === 0) {
        // 从相册选择
        chooseImageFromAlbum()
      }
      else if (res.tapIndex === 1) {
        // 使用微信头像
        useWechatAvatar()
      }
    },
  })
}

// 从相册选择图片
function chooseImageFromAlbum() {
  uni.chooseImage({
    count: 1,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      editForm.value.avatar = res.tempFilePaths[0]
    },
  })
}

// 使用微信头像
function useWechatAvatar() {
  // 获取微信用户信息
  uni.getUserProfile({
    desc: '用于完善会员资料',
    success: (res) => {
      // 获取微信头像
      editForm.value.avatar = res.userInfo.avatarUrl
      // 同时更新昵称
      editForm.value.nickname = res.userInfo.nickName
    },
    fail: () => {
      uni.showToast({
        title: '获取微信头像失败',
        icon: 'none',
      })
    },
  })
}

// 获取手机号
function getPhoneNumber(res: any) {
  console.log(res)
  if (res.detail.errMsg === 'getPhoneNumber:ok') {
    uni.showToast({
      title: '已获取手机号授权',
      icon: 'success',
    })
    // editForm.value.phone = '解析后的手机号'
  }
  else {
    uni.showToast({
      title: '获取手机号失败',
      icon: 'none',
    })
  }
}
</script>

<template>
  <sar-popup :visible="show" effect="zoom" @update:visible="(value) => emit('update:show', value)">
    <view class="w-[90vw] overflow-hidden rounded-2xl bg-white shadow-2xl">
      <!-- 头部区域 -->
      <view class="relative p-6 text-center text-white">
        <view class="absolute inset-0 bg-gray-800" />
        <view class="relative z-10">
          <view class="mb-3 flex justify-center">
            <view class="h-12 w-12 flex items-center justify-center rounded-full bg-white/20">
              <text class="text-2xl">👤</text>
            </view>
          </view>
          <text class="mb-2 block text-xl font-bold">编辑个人信息</text>
          <text class="text-sm opacity-90">修改您的头像和昵称</text>
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
                  v-if="editForm?.avatar" :src="editForm.avatar"
                  class="h-20 w-20 border-2 border-gray-200 rounded-full"
                />
                <image v-else src="@/static/images/avatar.png" class="h-20 w-20 rounded-full" mode="aspectFit" />
                <view
                  class="absolute h-6 w-6 flex items-center justify-center rounded-full bg-blue-500 text-white -bottom-1 -right-1"
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
              typ="nickname"
              placeholder="请输入昵称"
              class="w-full border-2 border-gray-200 rounded-lg px-4 py-3 text-base focus:border-blue-500"
            />
          </view>

          <!-- 手机号 -->
          <view class="space-y-2">
            <text class="text-base text-gray-800 font-semibold">手机号</text>
            <view class="flex items-center">
              <button class="flex-1 whitespace-nowrap px-4 py-3 text-sm text-gray-900" open-type="getPhoneNumber" @getphonenumber="getPhoneNumber">
                {{ editForm.phone || '获取手机号' }}
              </button>
            </view>
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
          class="flex-1 rounded-xl bg-gray-900 py-4 text-center text-white transition-all duration-200 active:scale-95"
          @click="handleConfirmEdit"
        >
          <text class="font-medium">确认修改</text>
        </view>
      </view>
    </view>
  </sar-popup>
</template>
