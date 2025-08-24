<route lang="jsonc" type="page">
{
"layout": "tabbar",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "课程管理"
}
}
</route>

<script setup lang="ts">
import type { WxCategoryItem, WxCourseItem, WxCourseListParams } from '@/api/types/course'
import { getWxCourseList } from '@/api/course'
import { CourseStore } from '@/store/course'

const { category } = CourseStore()
const searchKeyword = ref('')
const activeCategory = reactive({ category: 0, type: 0 })

const courses = ref<WxCourseItem[]>([])

const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(20)

// 过滤的分类
const categoryTab = computed<WxCategoryItem[]>(() => {
  return category.find(item => item.id === activeCategory.category)?.children || []
})

// 过滤的课程
const searchCourses = computed(() => {
  if (activeCategory.type === 0 && activeCategory.category === 0) {
    return courses.value
  }
  else if (activeCategory.type) {
    return courses.value.filter(item => item.category === activeCategory.type)
  }
  else {
    return courses.value.filter(item => item.category === activeCategory.category)
  }
})

// 获取课程列表
async function getCourses(loadMore = false) {
  if (loading.value)
    return

  loading.value = true

  try {
    const params: WxCourseListParams = {
      page: loadMore ? currentPage.value + 1 : 1,
      pageSize: pageSize.value,
      category: activeCategory.category ? activeCategory.category : null,
    }

    // 添加搜索关键词
    if (searchKeyword.value.trim()) {
      params.keyword = searchKeyword.value.trim()
    }

    const response = await getWxCourseList(params)

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
  finally {
    loading.value = false
  }
}

// 搜索处理
function handleSearch(value: string) {
  console.log('搜索关键词:', value)
  searchKeyword.value = value
  // 重置到第一页并重新加载数据
  currentPage.value = 1
  activeCategory.category = 0
  activeCategory.type = 0
  getCourses()
}

// 课程点击处理
function handleCourseClick(course) {
  uni.navigateTo({
    url: `/pages/course/detail?id=${course.id}`,
  })
}

// 加载更多
async function onLoadMore() {
  if (courses.value.length < total.value) {
    await getCourses(true)
  }
}

// 监听分类和标签改变
watch(
  () => [activeCategory.category],
  () => {
    activeCategory.type = 0
    getCourses()
  },
)

// 初始化加载
onMounted(async () => {
  getCourses()
})
</script>

<template>
  <view class="course-management">
    <!-- 头部 -->
    <HeaderSimple title="课程管理" class="px-3">
      <template #bottom>
        <SearchBar v-model="searchKeyword" placeholder="搜索课程名称" @search="handleSearch" />
      </template>
    </HeaderSimple>
    <view class="mt-2 h-full flex flex-1">
      <sar-sidebar v-model:current="activeCategory.category">
        <sar-sidebar-item :name="0" title="全部" />
        <sar-sidebar-item v-for="item in category" :key="item.id" :name="item.id" :title="item.categoryName" />
      </sar-sidebar>

      <view class="mx-3 h-full flex flex-1 flex-col gap-3">
        <view class="tabs flex gap-2">
          <view class="b-rd-1 tab" :class="`${activeCategory.type === 0 ? 'active' : ''}`" @click="activeCategory.type = 0">
            全部
          </view>
          <view
            v-for="tab in categoryTab" :key="tab.id" class="b-rd-1 tab"
            :class="`${activeCategory.type === tab.id ? 'active' : ''}`" @click="activeCategory.type = tab.id"
          >
            {{ tab.categoryName }}
          </view>
        </view>
        <view class="h-full flex-1 flex-col gap-3 overflow-y-auto">
          <view v-if="loading && searchCourses?.length === 0" class="loading p-4 text-center">
            加载中...
          </view>
          <view v-else-if="searchCourses?.length === 0" class="empty p-4 text-center">
            暂无课程数据
          </view>
          <view v-else class="courses-list">
            <view v-for="course in searchCourses" :key="course.id" class="mb-2">
              <CourseCard :course="course" @click="handleCourseClick" />
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
  </view>
</template>

<style lang="scss" scoped>
.course-management {
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.tab {
  background: var(--bg-primary);
  border: 1px solid var(--bg-inverse);
  color: var(--text-primary);
  padding: 10rpx 15rpx;
  font-size: 24rpx;

  &.active {
    background: var(--bg-inverse);
    color: var(--text-inverse);
  }
}
</style>
