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

// 推荐课程数据
const recommendedCourses = ref<Course[]>([
  {
    id: '1',
    title: '2023年软件开发工程师培训',
    image: 'https://picsum.photos/300/200?random=1',
    type: '图文',
    learners: 377,
    price: '399.00',
  },
  {
    id: '2',
    title: '2023年软件开发',
    image: 'https://picsum.photos/300/200?random=2',
    type: '图文',
    learners: 377,
    price: '299.00',
  },
  {
    id: '3',
    title: '前端开发进阶课程',
    image: 'https://picsum.photos/300/200?random=3',
    type: '视频',
    learners: 245,
    price: '599.00',
  },
  {
    id: '4',
    title: '移动端开发实战',
    image: 'https://picsum.photos/300/200?random=4',
    type: '音频',
    learners: 189,
    price: '免费',
  },
  {
    id: '5',
    title: '人工智能入门',
    image: 'https://picsum.photos/300/200?random=5',
    type: '图文',
    learners: 456,
    price: '799.00',
  },
])

function handleCourseClick(course: Course) {
  console.log('点击推荐课程:', course.title)
  uni.showToast({
    title: `查看课程: ${course.title}`,
    icon: 'none',
  })
}
</script>

<template>
  <view class="recommended-section">
    <view class="section-header mb-4">
      <text class="section-title text-lg font-bold">推荐</text>
    </view>

    <scroll-view
      class="courses-scroll"
      :scroll-x="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <view class="courses-container flex">
        <view
          v-for="course in recommendedCourses"
          :key="course.id"
          class="course-item mr-4"
          @click="handleCourseClick(course)"
        >
          <CourseCard :course="course" class="course-card-shadow" />
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.recommended-section {
  margin-bottom: 40rpx;
}

.section-title {
  font-size: 40rpx;
  color: var(--text-primary);
}

.courses-scroll {
  // 确保内容可以滚动
  white-space: nowrap;
}

.courses-container {
  display: flex;
  align-items: stretch;
}

.course-item {
  flex-shrink: 0;
  width: 240px; // 每个子项占240px
  min-width: 240px;
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
