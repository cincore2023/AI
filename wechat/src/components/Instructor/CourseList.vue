<!-- 课程列表组件 -->
<script setup lang="ts">
import { computed } from 'vue'
import CourseCard from '@/components/Home/CourseCard.vue'

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

// 定义组件Props，提供默认值
interface Props {
  courses: Course[]
  layout?: 'grid' | 'list'
  showEmpty?: boolean
  emptyText?: string
}

const props = withDefaults(defineProps<Props>(), {
  layout: 'list',
  showEmpty: true,
  emptyText: '暂无课程',
})

// 定义组件Emits
interface Emits {
  (e: 'courseClick', course: Course): void
  (e: 'emptyClick'): void
}

const emit = defineEmits<Emits>()

// 计算属性
const hasCourses = computed(() => props.courses && props.courses.length > 0)

const courseListClass = computed(() => ({
  'course-list': true,
  [`course-list-${props.layout}`]: true,
}))

// 方法定义
/**
 * 处理课程点击事件
 * @param course 课程信息
 */
function handleCourseClick(course: Course) {
  try {
    console.log('点击课程:', course.title)
    emit('courseClick', course)
  } catch (err) {
    console.error('课程点击处理失败:', err)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}

/**
 * 处理空状态点击事件
 */
function handleEmptyClick() {
  emit('emptyClick')
}

/**
 * 格式化价格显示
 * @param price 价格
 * @returns 格式化后的价格
 */
function formatPrice(price: string | number): string {
  if (price === '免费' || price === 0) {
    return '免费'
  }
  return `¥${price}`
}

/**
 * 格式化学习人数
 * @param learners 学习人数
 * @returns 格式化后的人数
 */
function formatLearners(learners: number): string {
  if (learners >= 10000) {
    return `${(learners / 10000).toFixed(1)}万人学习`
  }
  return `${learners}人学习`
}
</script>

<template>
  <view class="course-list-container">
    <!-- 课程列表 -->
    <view v-if="hasCourses" :class="courseListClass">
      <view
        v-for="course in courses"
        :key="course.id"
        class="course-item"
        @click="handleCourseClick(course)"
      >
        <!-- 使用现有的CourseCard组件 -->
        <CourseCard :course="course" />
      </view>
    </view>
    
    <!-- 空状态 -->
    <sar-empty
      v-else-if="showEmpty"
      :description="emptyText"
      @click="handleEmptyClick"
    />
  </view>
</template>

<style lang="scss" scoped>
.course-list-container {
  width: 100%;
}

.course-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.course-list-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300rpx, 1fr));
  gap: var(--spacing-md);
}

.course-list-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.course-item {
  // 点击效果
  transition: transform 0.2s ease;
  
  &:active {
    transform: scale(0.98);
  }
}

// 响应式设计
@media (max-width: 750rpx) {
  .course-list-grid {
    grid-template-columns: 1fr;
  }
}

@media (min-width: 751rpx) and (max-width: 1200rpx) {
  .course-list-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1201rpx) {
  .course-list-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
</style> 