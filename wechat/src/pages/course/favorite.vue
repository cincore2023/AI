<route lang="jsonc" type="page">
{
  "layout": "default",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "我的课程"
  }
}
</route>

<script setup lang="ts">
import type { WxFavoriteCourseItem } from '@/api/course'
import { getWxFavoriteCourses } from '@/api/course'

const courses = ref<WxFavoriteCourseItem[]>([])

const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(20)

// 获取收藏课程列表
async function getFavoriteCourses(loadMore = false) {
  if (loading.value)
    return

  loading.value = true

  try {
    const params = {
      page: loadMore ? currentPage.value + 1 : 1,
      pageSize: pageSize.value,
    }

    const response = await getWxFavoriteCourses(params)

    if (response.code === 0) {
      if (loadMore) {
        courses.value.push(...response.data.courses)
        currentPage.value = response.data.page
      }
      else {
        courses.value = response.data.courses
        currentPage.value = 1
      }
      total.value = response.data.total
    }
  }
  catch (error) {
    console.error('获取收藏课程失败:', error)
    uni.showToast({
      title: '获取收藏课程失败',
      icon: 'none',
    })
  }
  finally {
    loading.value = false
  }
}

// 课程点击处理
function handleCourseClick(course: WxFavoriteCourseItem) {
  uni.navigateTo({
    url: `/pages/course/detail?id=${course.id}`,
  })
}

// 加载更多
async function onLoadMore() {
  if (courses.value.length < total.value) {
    await getFavoriteCourses(true)
  }
}

// 初始化加载
onMounted(async () => {
  await getFavoriteCourses()
})

// 微信小程序分享功能
// #ifdef MP-WEIXIN
onShareAppMessage(() => {
  return {
    title: '我的课程',
    path: '/pages/course/favorite',
    imageUrl: '',
  }
})

onShareTimeline(() => {
  return {
    title: '我的课程',
    imageUrl: '',
  }
})
// #endif
</script>

<template>
  <view class="h-[100vh] flex flex-col overflow-hidden">
    <!-- 头部 -->
    <HeaderSimple title="我的课程" :show-back="true"/>

    <view class="mt-2 h-full flex flex-1 flex-col">
      <view class="h-full flex-1 flex-col gap-3 overflow-y-auto">
        <view v-if="loading && courses?.length === 0" class="loading p-4 text-center">
          加载中...
        </view>
        <view v-else-if="courses?.length === 0" class="empty p-4 text-center">
          暂无收藏的课程
        </view>
        <view v-else class="courses-list">
          <view v-for="course in courses" :key="course.id" class="mb-2">
            <FavoriteCourseCard :course="course" @click="handleCourseClick" />
          </view>

          <!-- 加载更多 -->
          <view v-if="courses.length < total" class="load-more p-4 text-center">
            <view v-if="loading" class="loading-text">
              加载中...
            </view>
            <button v-else class="load-more-btn" @click="onLoadMore">
              加载更多
            </button>
          </view>

          <view class="h-40 w-full" />
        </view>
      </view>
    </view>
  </view>
</template>