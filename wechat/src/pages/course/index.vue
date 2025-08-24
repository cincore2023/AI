<script setup lang="ts">
import { getWxCourseList, type WxCourseItem, type WxCourseListParams } from '@/api/course'

const searchKeyword = ref('')
const activeCategory = reactive({
  category: '',
  type: 0,
})

const loading = ref(false)
const courses = ref<WxCourseItem[]>([])
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(20)

const tabList = [
  { title: '全部', value: null },
  { title: '推荐', value: 'hot' },
  { title: '精品', value: 'exquisite' },
]

// 分类选项（可以从后端获取）
const categoryOptions = ref([
  { label: '全部', value: '' },
  { label: '软件开发', value: '1' },
  { label: 'AI赋能', value: '2' },
  { label: '设计', value: '3' },
  { label: '营销', value: '4' },
  { label: '商业', value: '5' },
])

// 获取课程列表
const getCourses = async (loadMore = false) => {
  if (loading.value) return
  
  loading.value = true
  
  try {
    const params: WxCourseListParams = {
      page: loadMore ? currentPage.value + 1 : 1,
      pageSize: pageSize.value,
    }
    
    // 添加筛选条件
    if (activeCategory.category) {
      params.category = parseInt(activeCategory.category)
    }
    
    // 添加推荐/精品筛选
    const currentTab = tabList[activeCategory.type]
    if (currentTab.value === 'hot') {
      params.hot = true
    } else if (currentTab.value === 'exquisite') {
      params.exquisite = true
    }
    
    const response = await getWxCourseList(params)
    
    if (response.code === 0) {
      if (loadMore) {
        courses.value.push(...response.data.courses)
        currentPage.value = response.data.page
      } else {
        courses.value = response.data.courses
        currentPage.value = 1
      }
      total.value = response.data.total
    }
  } catch (error) {
    console.error('获取课程列表失败:', error)
    uni.showToast({
      title: '获取课程列表失败',
      icon: 'none'
    })
  } finally {
    loading.value = false
  }
}

// 搜索处理
function handleSearch(value: string) {
  console.log('搜索关键词:', value)
  // TODO: 实现搜索功能
}

// 课程点击处理
function handleCourseClick(course: WxCourseItem) {
  uni.navigateTo({
    url: `/pages/course/detail?id=${course.id}`,
  })
}

// 加载更多
const onLoadMore = async () => {
  if (courses.value.length >= total.value) return
  await getCourses(true)
}

// 监听分类和标签改变
watch(
  () => [activeCategory.category, activeCategory.type],
  () => {
    getCourses()
  }
)

// 初始化加载
onMounted(() => {
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
        <sar-sidebar-item v-for="item in categoryOptions" :key="item.value" :name="item.value" :title="item.label" />
      </sar-sidebar>

      <view class="mx-3 h-full flex flex-1 flex-col gap-3">
        <view class="tabs flex gap-2">
          <view
            v-for="(tab, idx) in tabList" :key="tab.title" class="b-rd-1 tab"
            :class="`${activeCategory.type === idx ? 'active' : ''}`" @click="activeCategory.type = idx"
          >
            {{ tab.title }}
          </view>
        </view>
        <view class="h-full flex-1 flex-col gap-3 overflow-y-auto">
          <view v-if="loading && courses.length === 0" class="loading text-center p-4">
            加载中...
          </view>
          <view v-else-if="courses.length === 0" class="empty text-center p-4">
            暂无课程数据
          </view>
          <view v-else class="courses-list">
            <view v-for="course in courses" :key="course.id" class="mb-2">
              <CourseCard :course="course" @click="handleCourseClick"/>
            </view>
            
            <!-- 加载更多 -->
            <view v-if="courses.length < total" class="load-more text-center p-4">
              <view v-if="loading" class="loading-text">加载中...</view>
              <button v-else class="load-more-btn" @click="onLoadMore">加载更多</button>
            </view>
            
            <view class="h-40 w-full"/>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<route lang="jsonc" type="page">
{
"layout": "tabbar",
"style": {
"navigationStyle": "custom",
"navigationBarTitleText": "课程管理"
}
}
</route>

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
