<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/store/user'
import SearchBar from '@/components/SearchBar/SearchBar.vue'
import EditUserInfoModal from '@/components/Personal/Modals/EditUserInfoModal.vue'

// 响应式数据
const searchText = ref('')
const safeAreaInsets = ref<any>(null)
const { wechatUser, isLoggedIn } = storeToRefs(useUserStore())

// 编辑弹框相关
const editUserInfoModalRef = ref()

// 获取屏幕边界到安全区域距离
const systemInfo = uni.getWindowInfo()

safeAreaInsets.value = systemInfo.safeArea
  ? {
      top: systemInfo.safeArea.top,
      right: systemInfo.windowWidth - systemInfo.safeArea.right,
      bottom: systemInfo.windowHeight - systemInfo.safeArea.bottom,
      left: systemInfo.safeArea.left,
    }
  : null

// 计算属性
const greeting = computed(() => {
  const hour = new Date().getHours()
  if (hour < 12)
    return '上午好'
  if (hour < 18)
    return '下午好'
  return '晚上好'
})

const headerStyle = computed(() => ({
  paddingTop: `${safeAreaInsets.value?.top}px` || '0px',
}))

function handleCompleteInfo() {
  if (!wechatUser.value?.phone_number) editUserInfoModalRef.value?.open()
}

// 点击头部区域处理函数
function handleHeaderClick() {
  // 如果用户未登录，跳转到登录页面
  if (!isLoggedIn.value) {
    uni.navigateTo({
      url: '/pages/login/login'
    })
  } else {
    // 如果已登录，完善信息
    handleCompleteInfo()
  }
}

function handleSearch(value: string) {
  console.log('搜索内容:', value)
  // 这里可以添加搜索逻辑
  uni.showToast({
    title: '搜索功能开发中',
    icon: 'none',
  })
}
</script>

<template>
  <view class="header" :style="headerStyle">
    <!-- 头部内容 -->
    <view class="header-content">
      <view class="left-section" @click="handleHeaderClick">
        <view class="greeting">
          <text class="greeting-text">{{ greeting }}</text>
          <text class="user-name">{{ wechatUser?.nickname || '未登录' }}</text>
        </view>
        <text v-if="!wechatUser?.phone_number && isLoggedIn" class="complete-hint">点击完善您的信息</text>
        <text v-else-if="!isLoggedIn" class="complete-hint">点击登录</text>
      </view>
    </view>

    <!-- 搜索框 -->
    <view class="search-section">
      <SearchBar
        v-model="searchText"
        placeholder="搜课程名称/智能体"
        @search="handleSearch"
      />
    </view>
  </view>
  <EditUserInfoModal ref="editUserInfoModalRef" />
</template>

<style lang="scss" scoped>
.header {
  position: relative;
  z-index: 100;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding-top: 20rpx;
}

.left-section {
  flex: 1;
  cursor: pointer;
}

.greeting {
  margin-bottom: 10rpx;
}

.greeting-text {
  font-size: 32rpx;
  font-weight: bold;
  color: #333333;
  margin-right: 10rpx;
}

.user-name {
  font-size: 32rpx;
  font-weight: bold;
  color: #333333;
}

.complete-hint {
  font-size: 24rpx;
  color: #666666;
  opacity: 0.8;
}

.search-section {
  padding-top: 20rpx;
  padding-bottom: 12rpx;
}
</style>
