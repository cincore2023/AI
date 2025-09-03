<script setup lang="ts">
import { wxDecryptPhone, wxUpdateUserInfo } from '@/api/wechat/userinfo'
import { useUserStore } from '@/store/user'

const show = ref(false)

// 获取用户存储
const userStore = useUserStore()

// 编辑表单
const editForm = ref({
  nickname: userStore.wechatUser.nickname || '',
  phone: userStore.wechatUser.phone_number || '',
  avatar: userStore.wechatUser.avatar || '',
})

// 监听show属性变化，重置表单
watch(() => show.value, (newVal) => {
  if (newVal) {
    // 重置表单为当前用户信息
    editForm.value.nickname = userStore.wechatUser.nickname || ''
    editForm.value.phone = userStore.wechatUser.phone_number || ''
    editForm.value.avatar = userStore.wechatUser.avatar || ''
  }
})

// 确认编辑
async function handleConfirmEdit() {
  try {
    let avatarUrl = editForm.value.avatar

    // 如果头像是本地文件路径，需要上传到服务器
    if (avatarUrl && (avatarUrl.startsWith('http://tmp') || avatarUrl.startsWith('wxfile://'))) {
      try {
        const uploadResult = await new Promise((resolve, reject) => {
          uni.uploadFile({
            url: '/api/wx/UploadAvatar', // 服务器上传地址
            filePath: avatarUrl,
            name: 'file',
            header: {
              // 添加认证头
              Authorization: `Bearer ${uni.getStorageSync('token')}`, // 根据实际情况调整
            },
            success: (uploadRes) => {
              const data = JSON.parse(uploadRes.data)
              if (data.code === 0) {
                resolve(data.data)
              } else {
                reject(new Error(data.msg || '上传失败'))
              }
            },
            fail: (uploadErr) => {
              reject(uploadErr)
            },
          })
        })

        avatarUrl = uploadResult as string // 使用上传后返回的URL
      }
      catch (uploadError) {
        uni.showToast({
          title: '头像上传失败',
          icon: 'none',
        })
        console.error('头像上传失败:', uploadError)
        return
      }
    }

    // 更新用户信息
    await wxUpdateUserInfo({
      nickname: editForm.value.nickname,
      avatar: avatarUrl,
    })

    // 更新store中的用户信息
    userStore.setWechatUser({
      ...userStore.wechatUser,
      nickname: editForm.value.nickname,
      avatar: avatarUrl,
    })

    uni.showToast({
      title: '信息更新成功',
      icon: 'success',
    })
    handleCancelEdit()
  }
  catch (error) {
    uni.showToast({
      title: '更新失败',
      icon: 'none',
    })
    console.error('更新用户信息失败:', error)
  }
}

// 取消编辑
function handleCancelEdit() {
  show.value = false
}

function handleShowEditModal() {
  show.value = true
}

// 选择头像方式
function handleSelectAvatar() {
  uni.showActionSheet({
    itemList: ['从相册选择', '使用微信头像'],
    success: (res) => {
      if (res.tapIndex === 0) {
        // 从相册选择
        chooseImageFromAlbum()
      } else if (res.tapIndex === 1) {
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
    success: async (res) => {
      editForm.value.avatar = res.tempFilePaths[0]
    },
    fail: (error) => {
      uni.showToast({
        title: '头像选择失败',
        icon: 'none',
      })
      console.error('头像选择失败:', error)
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
async function getPhoneNumber(res: any) {
  console.log(res)
  // 这里应该将code发送到后端解析手机号
  if (res.detail.errMsg === 'getPhoneNumber:ok') {
    try {
      // 调用后端接口解密手机号
      const response = await wxDecryptPhone({ code: res.detail.code })
      editForm.value.phone = response.data.phoneNumber

      // 更新store中的用户信息
      userStore.setWechatUser({
        ...userStore.wechatUser,
        phone_number: response.data.phoneNumber,
      })

      uni.showToast({
        title: '手机号获取成功',
        icon: 'success',
      })
    }
    catch (error) {
      uni.showToast({
        title: '手机号获取失败',
        icon: 'none',
      })
      console.error('手机号解密失败:', error)
    }
  } else {
    uni.showToast({
      title: '获取手机号失败',
      icon: 'none',
    })
  }
}

defineExpose({ open: handleShowEditModal, close: handleCancelEdit })
</script>

<template>
  <sar-popup :visible="show" effect="zoom"     @overlay-click="handleCancelEdit">
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
          <text class="text-sm opacity-90">修改您的头像和昵称</text>
        </view>
      </view>

      <!-- 内容区域 -->
      <view class="p-6">
        <view class="space-y-6">
          <!-- 头像 -->
          <view class="space-y-3">
            <text class="text-base text-gray-800 font-semibold">头像</text>
            <view class="flex justify-center" @click="handleSelectAvatar">
              <view class="relative">
                <image
                    v-if="editForm?.avatar" :src="editForm.avatar"
                    class="h-20 w-20 border-2 border-gray-200 rounded-full"
                />
                <image v-else src="@/static/images/avatar.png" class="h-20 w-20 rounded-full" mode="aspectFit"/>
                <view
                    class="absolute h-6 w-6 flex items-center justify-center rounded-full bg-blue-500 text-white -bottom-1 -right-1">
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
            <view class="flex items-center">
              <button class="flex-1 whitespace-nowrap px-4 py-3 text-sm text-gray-900" open-type="getPhoneNumber"
                      @getphonenumber="getPhoneNumber">
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
