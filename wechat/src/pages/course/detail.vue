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
import { getWxCourseDetail } from '@/api/course'
import type { WxCourseDetailItem } from "@/api/types/course";

import CourseInfo from './components/CourseInfo.vue'
import CourseContent from './components/CourseContent.vue'
import CourseActions from './components/CourseActions.vue'

const courseId = ref('')
const { isMember } = useUserStore()




const courseDetail = ref<WxCourseDetailItem | null>(null)
const loading = ref(false)

// 获取课程详情
async function getCourseDetail(id: string) {
  loading.value = true
  try {
    const { data } = await getWxCourseDetail(id)
    courseDetail.value = data
    console.log('课程详情获取成功:', data)
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
    <CourseActions :is-member="isMember"/>
  </view>
</template>
