<script setup lang="ts">

interface Course {
  id: string
  title: string
  description: string
  price: number
  studentCount: number
  status: 'active' | 'inactive' | 'draft'
  image: string
  category: string
  createdAt: string
}

const searchKeyword = ref('')
const activeCategory = reactive({
  category: 'development',
  type: 0,
})

const tabList = [{ title: '标签0' }, { title: '标签1' }, { title: '标签2' }]

// 分类选项
const categoryOptions = ref([
  { label: '软件开发', value: 'development' },
  { label: 'AI赋能', value: 'ai' },
  { label: '设计', value: 'design' },
  { label: '营销', value: 'marketing' },
  { label: '商业', value: 'business' },
])

// 模拟课程数据
const courses = ref<Course[]>([
  {
    id: '1',
    title: '2023年软件开发工程师培训',
    description: '全面的软件开发技能培训，包含前端、后端、数据库等核心技术',
    image: 'https://picsum.photos/400/200?random=1',
    price: 399,
    studentCount: 377,
    status: 'active',
    category: 'development',
    createdAt: '2023-12-01',
  },
  {
    id: '2',
    title: 'AI赋能实战课程',
    description: '学习AI技术在实际项目中的应用，提升工作效率',
    image: 'https://picsum.photos/400/200?random=1',
    price: 599,
    studentCount: 245,
    status: 'active',
    category: 'ai',
    createdAt: '2023-12-05',
  },
  {
    id: '3',
    title: '前端开发进阶课程',
    description: '深入学习Vue、React等前端框架，掌握现代前端开发技术',
    image: 'https://picsum.photos/400/200?random=1',
    price: 299,
    studentCount: 156,
    status: 'draft',
    category: 'development',
    createdAt: '2023-12-10',
  },
  {
    id: '4',
    title: 'UI/UX设计实战',
    description: '从零开始学习UI/UX设计，掌握设计思维和工具使用',
    image: 'https://picsum.photos/400/200?random=1',
    price: 499,
    studentCount: 189,
    status: 'active',
    category: 'design',
    createdAt: '2023-12-15',
  },
  {
    id: '5',
    title: '数字营销策略',
    description: '学习现代数字营销策略，包括社交媒体、内容营销等',
    image: 'https://picsum.photos/400/200?random=1',
    price: 399,
    studentCount: 267,
    status: 'inactive',
    category: 'marketing',
    createdAt: '2023-12-20',
  },
])

// 搜索处理
function handleSearch(value: string) {
  console.log('搜索关键词:', value)
}

// 课程点击处理
function handleCourseClick(course: Course) {
  uni.navigateTo({
    url: `/pages/course-management/detail?id=${course.id}`,
  })
}

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
          <sar-scroll-spy v-model:current="activeCategory.category">
            <view v-for="course in courses" :key="course.id" class="mb-2">
              <sar-scroll-spy-anchor :name="course.category">
                <CourseCard :course="course" @click="handleCourseClick"/>
              </sar-scroll-spy-anchor>
            </view>
            <view class="h-40 w-full"/>
          </sar-scroll-spy>
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
