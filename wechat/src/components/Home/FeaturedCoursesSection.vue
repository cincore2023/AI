<script setup lang="ts">
import CourseCard from './CourseCard.vue'

interface Course {
  id: string
  title: string
  image: string
  type: string
  learners: number
  price: string | number
}

// 精选课程数据
const featuredCourses = ref<Course[]>([
  {
    id: '3',
    title: '2023年软件开发工程师培训',
    image: 'https://picsum.photos/300/200?random=3',
    type: '视频',
    learners: 377,
    price: '399.00',
  },
  {
    id: '4',
    title: '2023年软件开发工程师培训',
    image: 'https://picsum.photos/300/200?random=4',
    type: '音频',
    learners: 377,
    price: '免费',
  },
  {
    id: '6',
    title: 'React Native开发实战',
    image: 'https://picsum.photos/300/200?random=6',
    type: '视频',
    learners: 312,
    price: '699.00',
  },
  {
    id: '7',
    title: 'Vue.js高级教程',
    image: 'https://picsum.photos/300/200?random=7',
    type: '图文',
    learners: 278,
    price: '499.00',
  },
])

function handleCourseClick(course: Course) {
  console.log('点击精选课程:', course.title)
  uni.showToast({
    title: `查看课程: ${course.title}`,
    icon: 'none',
  })
}
</script>

<template>
  <view class="featured-section">
    <view class="section-header mb-4">
      <text class="section-title text-xl font-bold">精选课程</text>
    </view>

    <view class="courses-grid grid grid-cols-2 gap-3">
      <CourseCard
        v-for="course in featuredCourses"
        :key="course.id"
        :course="course"
        class="course-card-shadow"
        @click="handleCourseClick(course)"
      />
    </view>
  </view>
</template>

<style lang="scss" scoped>
.featured-section {
  margin-bottom: 40rpx;
}

.section-title {
  font-size: 40rpx;
  color: var(--text-primary);
}

.course-card-shadow {
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;

  &:active {
    transform: translateY(-2rpx);
    box-shadow: var(--shadow-lg);
  }
}
</style>
