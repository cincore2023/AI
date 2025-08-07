<!-- 讲师详情页面 -->
<route lang="jsonc" type="page">
{
  "layout": "default",
  "style": {
    "navigationStyle": "custom",
    "navigationBarTitleText": "讲师详情"
  }
}
</route>

<script setup lang="ts">
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import CourseList from '@/components/Instructor/CourseList.vue'
import InstructorBio from '@/components/Instructor/InstructorBio.vue'
import InstructorProfile from '@/components/Instructor/InstructorProfile.vue'
import InstructorTabs from '@/components/Instructor/InstructorTabs.vue'

// 定义讲师详情接口
interface InstructorDetail {
  id: string
  name: string
  title: string
  avatar: string
  bio: string
  experience: string
  specialties: string[]
  courses: Course[]
}

// 定义课程接口
interface Course {
  id: string
  title: string
  image: string
  type: string
  learners: number
  price: string | number
  description: string
}

// 定义页面Props
interface PageProps {
  instructorId?: string
}

// 定义组件Props，提供默认值
const props = withDefaults(defineProps<PageProps>(), {
  instructorId: '',
})

const emit = defineEmits<PageEmits>()

// 定义组件Emits
interface PageEmits {
  (e: 'courseClick', course: Course): void
  (e: 'error', error: Error): void
}

// 响应式数据
const activeTab = ref<'courses' | 'bio'>('courses')
const loading = ref(false)
const error = ref<string | null>(null)

// 模拟讲师数据
const instructorData = reactive<InstructorDetail>({
  id: '1',
  name: '张教授',
  title: '抖迅AI商学院院长',
  avatar: 'https://picsum.photos/200/200?random=10',
  bio: '张教授拥有20年的教育和技术经验，专注于人工智能和商业智能领域的研究与教学。曾在多家知名企业担任技术总监，拥有丰富的实战经验。',
  experience: '20年教育和技术经验',
  specialties: ['人工智能', '机器学习', '深度学习', '商业智能', '数据分析'],
  courses: [
    {
      id: '1',
      title: '2023年软件开发工程师培训',
      image: 'https://picsum.photos/300/200?random=1',
      type: '图文',
      learners: 377,
      price: '399.00',
      description: '全面的软件开发培训课程，涵盖前端、后端、数据库等核心技术。',
    },
    {
      id: '2',
      title: '人工智能入门与实践',
      image: 'https://picsum.photos/300/200?random=2',
      type: '视频',
      learners: 245,
      price: '599.00',
      description: '从零开始学习人工智能，理论与实践相结合。',
    },
    {
      id: '3',
      title: '机器学习算法精讲',
      image: 'https://picsum.photos/300/200?random=3',
      type: '图文',
      learners: 189,
      price: '799.00',
      description: '深入讲解机器学习核心算法，包含大量实战案例。',
    },
  ],
})

// 计算属性
const tabList = computed(() => [
  { title: '课程', value: 'courses' },
  { title: '简介', value: 'bio' },
])

// 方法定义
/**
 * 处理课程点击事件
 * @param course 课程信息
 */
function handleCourseClick(course: Course) {
  try {
    console.log('点击课程:', course.title)
    emit('courseClick', course)

    // 跳转到课程详情页
    uni.navigateTo({
      url: `/pages/course/detail?id=${course.id}`,
      fail: (err) => {
        console.error('跳转失败:', err)
        uni.showToast({
          title: '页面跳转失败',
          icon: 'error',
        })
      },
    })
  }
  catch (err) {
    const error = err instanceof Error ? err : new Error('未知错误')
    emit('error', error)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}

/**
 * 处理标签页切换
 * @param value 标签页值
 */
function handleTabChange(value: string) {
  activeTab.value = value as 'courses' | 'bio'
}

/**
 * 加载讲师数据
 */
async function loadInstructorData() {
  loading.value = true
  error.value = null

  try {
    // 模拟API调用
    await new Promise(resolve => setTimeout(resolve, 1000))

    // 这里应该根据instructorId调用实际的API
    if (props.instructorId) {
      console.log('加载讲师ID:', props.instructorId)
    }

    // 模拟加载成功
    console.log('讲师数据加载成功')
  }
  catch (err) {
    const errorMessage = err instanceof Error ? err.message : '加载失败'
    error.value = errorMessage
    emit('error', err instanceof Error ? err : new Error(errorMessage))

    uni.showToast({
      title: '数据加载失败',
      icon: 'error',
    })
  }
  finally {
    loading.value = false
  }
}

/**
 * 处理错误
 * @param err 错误对象
 */
function handleError(err: Error) {
  console.error('页面错误:', err)
  error.value = err.message
  emit('error', err)
}

// 生命周期
onMounted(() => {
  loadInstructorData()
})

// 暴露方法给父组件
defineExpose({
  loadInstructorData,
  handleCourseClick,
})
</script>

<template>
  <view class="instructor-detail-page">
    <!-- 头部导航 -->
    <HeaderSimple title="讲师详情" :show-back="true" />

    <!-- 加载状态 -->
    <sar-loading v-if="loading" theme="primary" />

    <!-- 错误状态 -->
    <sar-empty v-else-if="error" :description="error" />

    <!-- 主要内容 -->
    <template v-else>
      <scroll-view
        class="content-scroll"
        :scroll-y="true"
        :show-scrollbar="false"
        enhanced="true"
      >
        <!-- 讲师信息卡片 -->
        <InstructorProfile
          :instructor="instructorData"
          class="instructor-profile"
        />

        <!-- 标签页 -->
        <InstructorTabs
          v-model:current="activeTab"
          :list="tabList"
          @change="handleTabChange"
        />

        <!-- 标签页内容 -->
        <view class="tab-content">
          <!-- 课程列表 -->
          <CourseList
            v-if="activeTab === 'courses'"
            :courses="instructorData.courses"
            @course-click="handleCourseClick"
          />

          <!-- 讲师简介 -->
          <InstructorBio
            v-else-if="activeTab === 'bio'"
            :instructor="instructorData"
          />
        </view>
      </scroll-view>
    </template>
  </view>
</template>

<style lang="scss" scoped>
.instructor-detail-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.content-scroll {
  flex: 1;
  overflow: hidden;
}

.instructor-profile {
  margin-bottom: var(--spacing-md);
}

.tab-content {
  padding: var(--spacing-md) 0;
  min-height: 400rpx;
}
</style>
