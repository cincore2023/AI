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

const tabList = [{ title: '全部课程' }, { title: '已发布' }, { title: '草稿' }]

const categoryOptions = ref([
  { label: '软件开发', value: 'development' },
  { label: 'AI赋能', value: 'ai' },
  { label: '设计', value: 'design' },
  { label: '营销', value: 'marketing' },
  { label: '商业', value: 'business' },
])

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
    image: 'https://picsum.photos/400/200?random=2',
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
    image: 'https://picsum.photos/400/200?random=3',
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
    image: 'https://picsum.photos/400/200?random=4',
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
    image: 'https://picsum.photos/400/200?random=5',
    price: 399,
    studentCount: 267,
    status: 'inactive',
    category: 'marketing',
    createdAt: '2023-12-20',
  },
])

function handleSearch(value: string) {
  console.log('搜索关键词:', value)
}

function handleCourseClick(course: Course) {
  uni.navigateTo({
    url: `/pages/course-management/detail?id=${course.id}`,
  })
}

onMounted(() => {
  console.log('课程管理页面加载完成')
})
</script>

<template>
  <view class="course-management">
    <HeaderSimple title="课程管理" class="px-3">
      <template #bottom>
        <SearchBar
          v-model="searchKeyword"
          placeholder="搜索课程名称"
          @search="handleSearch"
        />
      </template>
    </HeaderSimple>

    <view class="content-container">
      <sar-sidebar v-model:current="activeCategory.category">
        <sar-sidebar-item
          v-for="item in categoryOptions"
          :key="item.value"
          :name="item.value"
          :title="item.label"
        />
      </sar-sidebar>

      <view class="main-content">
        <view class="tabs">
          <view
            v-for="(tab, idx) in tabList"
            :key="tab.title"
            class="tab"
            :class="{ active: activeCategory.type === idx }"
            @click="activeCategory.type = idx"
          >
            {{ tab.title }}
          </view>
        </view>

        <view class="scroll-container">
          <sar-scroll-spy
            v-model:current="activeCategory.category"
            scrollable
          >
            <view
              v-for="course in courses"
              :key="course.id"
              class="course-item"
            >
              <sar-scroll-spy-anchor :name="course.category">
                <CourseCard
                  :course="course"
                  @click="handleCourseClick"
                />
              </sar-scroll-spy-anchor>
            </view>
            <view class="bottom-spacer" />
          </sar-scroll-spy>
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.course-management {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-page);

  .content-container {
    flex: 1;
    display: flex;
    overflow: hidden;
  }

  .main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: 0 12rpx;
  }

  .tabs {
    display: flex;
    gap: 16rpx;
    padding: 16rpx 0;
    background-color: var(--bg-page);

    .tab {
      padding: 12rpx 24rpx;
      border-radius: 8rpx;
      background-color: var(--bg-secondary);
      color: var(--text-secondary);
      font-size: 28rpx;
      transition: all 0.3s;

      &.active {
        background-color: var(--primary);
        color: white;
      }
    }
  }

  .scroll-container {
    flex: 1;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;

    &::-webkit-scrollbar {
      display: none;
    }
  }

  .course-item {
    margin-bottom: 24rpx;
  }

  .bottom-spacer {
    height: 32rpx;
  }
}
</style>

<route lang="jsonc" type="page">
{
  "layout": "tabbar",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "课程管理",
    "backgroundColor": "#f5f5f5"
  }
}
</route>