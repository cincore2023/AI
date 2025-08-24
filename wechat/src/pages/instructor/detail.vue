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
import type { ITeacherDetailItem } from '@/api/types/teacher'
import { getTeacherDetail } from '@/api/teacher'
import HeaderSimple from '@/components/Header/HeaderSimple.vue'
import CourseList from '@/components/Instructor/CourseList.vue'
import InstructorBio from '@/components/Instructor/InstructorBio.vue'

import InstructorProfile from '@/components/Instructor/InstructorProfile.vue'

// 响应式数据
const activeTab = ref<number>(0)
const loading = ref(false)
const error = ref<string | null>(null)

// 模拟讲师数据
const instructorData = ref<ITeacherDetailItem>()

// 计算属性
const tabList = computed(() => [
  { title: '课程', value: 0 },
  { title: '简介', value: 1 },
])

/**
 * 处理标签页切换
 * @param value 标签页值
 */
function handleTabChange(value: number) {
  activeTab.value = value
}

/**
 * 加载讲师数据
 */
async function loadInstructorData(id: string) {
  loading.value = true
  const { data } = await getTeacherDetail(id)
  instructorData.value = data.teacher
  loading.value = false
}

onLoad((options: any) => {
  if (options?.id) {
    loadInstructorData(options?.id)
  }
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
        <InstructorProfile :instructor="instructorData" class="instructor-profile" />

        <!-- 标签页 -->
        <view class="tab-container pb-4">
          <sar-tabs v-model:current="activeTab" :list="tabList" class="course-tabs" @change="handleTabChange" />
        </view>

        <!-- 标签页内容 -->
        <view class="tab-content">
          <!-- 课程列表 -->
          <CourseList v-if="activeTab === 0" :courses="instructorData?.courses" />

          <!-- 讲师简介 -->
          <InstructorBio v-else-if="activeTab === 1" :instructor="instructorData" />
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

.tab-container {
  border-top: 1px solid var(--border-primary);
}

.course-tabs {
  --sar-tabs-item-color: var(--text-tertiary);
  --sar-tabs-item-active-color: var(--primary-color);
  --sar-tabs-item-active-font-weight: bold;
  --sar-tabs-line-color: var(--primary-color);
}
</style>
