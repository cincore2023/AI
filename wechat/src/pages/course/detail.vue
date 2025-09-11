<route lang="jsonc" type="page">
{
"layout": "defaultV2",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "课程详情"
}
}
</route>

<script setup lang="ts">
import { useUserStore } from '@/store/user'
import { useFavoriteStore } from '@/store/favorite'
import { getWxCourseDetail } from '@/api/course'
import { wxUpdateMembership } from '@/api/wechat/userinfo'
import type { WxCourseDetailItem } from "@/api/types/course";

import CourseInfo from './components/CourseInfo.vue'
import CourseContent from './components/CourseContent.vue'
import CourseActions from './components/CourseActions.vue'
import MembershipModal from '@/components/Personal/Modals/MembershipModal.vue'

const courseId = ref('')
const { isMember } = useUserStore()
const favoriteStore = useFavoriteStore()

const courseDetail = ref<WxCourseDetailItem | null>(null)
const loading = ref(false)
const isFavorite = ref(false)

// 添加会员开通弹框显示状态
const showMembershipModal = ref(false)

// 获取课程详情
async function getCourseDetail(id: string) {
  loading.value = true
  try {
    const { data } = await getWxCourseDetail(id)
    courseDetail.value = data
    console.log('课程详情获取成功:', data)
    
    // 获取课程收藏状态
    if (data.id) {
      isFavorite.value = await favoriteStore.getCourseFavoriteStatus(data.id)
    }
  } catch (error) {
    console.error('获取课程详情失败:', error)
    uni.showToast({
      title: '获取课程详情失败',
      icon: 'error'
    })
  } finally {
    loading.value = false
  }
}

// 切换收藏状态
async function toggleFavorite() {
  if (!courseId.value) return
  
  const courseIdNum = parseInt(courseId.value)
  isFavorite.value = await favoriteStore.toggleCourseFavorite(courseIdNum)
}

// 打开会员开通弹框
function openMembershipModal() {
  showMembershipModal.value = true
}

// 下载资料
function downloadMaterial(material: any) {
  if (!isMember) {
    uni.showToast({
      title: '会员专享功能',
      icon: 'none',
    })
    return
  }

  uni.showLoading({
    title: '下载中...',
  })

  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({
      title: '下载成功',
      icon: 'success',
    })
  }, 2000)
}

// 检查是否为iOS设备
function checkIOSPayment() {
  // #ifdef APP-PLUS
  const systemInfo = uni.getSystemInfoSync()
  if (systemInfo.platform === 'ios') {
    uni.showModal({
      title: '绑定确认',
      content: '非常抱歉，苹果用户暂不支持购买',
      showCancel: false,
    })
  }
  // #endif
}

onMounted(async () => {
  // 检查会员状态

  // 检查iOS支付限制
  checkIOSPayment()
})

onLoad((options) => {
  if (options?.id) {
    courseId.value = options.id
    getCourseDetail(options.id)
  }
})

// 微信小程序分享功能
// #ifdef MP-WEIXIN
onShareAppMessage((res) => {
  if (res.from === 'button') {
    // 来自页面内转发按钮
    console.log('来自页面内转发按钮')
  }
  
  return {
    title: courseDetail.value?.courseTitle || '推荐一门好课',
    path: `/pages/course/detail?id=${courseId.value}`,
    imageUrl: courseDetail.value?.coverImage || ''
  }
})

onShareTimeline(() => {
  return {
    title: courseDetail.value?.courseTitle || '推荐一门好课',
    imageUrl: courseDetail.value?.coverImage || ''
  }
})
// #endif
</script>

<template>
  <view class="h-[100vh] flex flex-col overflow-hidden">
    <!-- 头部 -->
    <HeaderSimple title="课程详情" :show-back="true" class="px-[30rpx]"/>

    <scroll-view class="no-scrollbar flex flex-1 flex-col"
                 :scroll-y="true"
                 :show-scrollbar="false"
                 enhanced="true">
      <view class="px-[30rpx]">

        <!-- 课程图片轮播 -->
        <HomeSwiper/>

        <!-- 课程信息 -->
        <CourseInfo :detail="courseDetail"/>

        <!-- 标签页内容 -->
        <CourseContent :detail="courseDetail"/>
      </view>

    </scroll-view>
    <!-- 底部操作栏 -->
    <CourseActions 
      :is-member="isMember" 
      :is-favorite="isFavorite"
      @toggle-favorite="toggleFavorite"
      @action="openMembershipModal"
    />
    
    <!-- 会员开通弹框 -->
    <MembershipModal :show="showMembershipModal" @update:show="(value) => showMembershipModal = value"/>
  </view>
</template>