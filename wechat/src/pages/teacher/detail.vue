<template>
  <view class="teacher-detail-demo">
    <view class="header">
      <text class="title">教师详情演示</text>
      <view class="controls">
        <input 
          v-model="teacherId" 
          class="input" 
          placeholder="请输入教师ID（如：1）" 
          type="number"
        />
        <button @click="loadTeacherDetail" class="load-btn">
          {{ loading ? '加载中...' : '获取详情' }}
        </button>
      </view>
    </view>

    <view class="loading" v-if="loading">
      <text>加载教师详情中...</text>
    </view>

    <view class="teacher-detail" v-else-if="teacherDetail">
      <!-- 教师基本信息 -->
      <view class="teacher-info">
        <image class="avatar" :src="teacherDetail.avatar" mode="aspectFill" />
        <view class="info">
          <text class="name">{{ teacherDetail.name }}</text>
          <text class="description">{{ teacherDetail.description }}</text>
          <view class="introduction" v-html="teacherDetail.introduction"></view>
          <text class="sort">排序: {{ teacherDetail.sort }}</text>
        </view>
      </view>

      <!-- 教师课程列表 -->
      <view class="courses-section">
        <text class="section-title">教师课程 ({{ teacherDetail.courses.length }})</text>
        
        <view class="courses-list" v-if="teacherDetail.courses.length > 0">
          <view class="course-card" v-for="course in teacherDetail.courses" :key="course.id">
            <image class="course-cover" :src="course.coverImage" mode="aspectFill" />
            <view class="course-info">
              <text class="course-title">{{ course.courseTitle }}</text>
              <view class="course-meta">
                <text class="course-type">{{ course.type === 'img' ? '图文' : '视频' }}</text>
                <text class="course-price">¥{{ course.price }}</text>
                <text class="course-original-price" v-if="course.originalPrice > course.price">
                  原价: ¥{{ course.originalPrice }}
                </text>
              </view>
              <text class="course-students">{{ course.apprenticeCount }} 人学习</text>
              <text class="course-status" :class="{ 'on-sale': course.onSale, 'off-sale': !course.onSale }">
                {{ course.onSale ? '已上架' : '未上架' }}
              </text>
              <view class="course-details" v-if="course.viewDetails">
                <text class="details-title">课程简介:</text>
                <text class="details-content">{{ course.viewDetails }}</text>
              </view>
            </view>
          </view>
        </view>

        <view class="no-courses" v-else>
          <text>该教师暂无课程</text>
        </view>
      </view>
    </view>

    <view class="empty" v-else-if="!loading && !error">
      <text>请输入教师ID获取详情</text>
    </view>

    <view class="error" v-if="error">
      <text class="error-text">{{ error }}</text>
      <button @click="loadTeacherDetail" class="retry-btn">重试</button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { getTeacherDetail } from '@/api/teacher'
import type { ITeacherDetailItem } from '@/api/types/teacher'

const teacherId = ref('1') // 默认教师ID
const teacherDetail = ref<ITeacherDetailItem | null>(null)
const loading = ref(false)
const error = ref('')

const loadTeacherDetail = async () => {
  if (!teacherId.value) {
    error.value = '请输入教师ID'
    return
  }

  try {
    loading.value = true
    error.value = ''
    teacherDetail.value = null
    
    const response = await getTeacherDetail(teacherId.value)
    teacherDetail.value = response.teacher
    
    console.log('教师详情加载成功:', teacherDetail.value)
  } catch (err: any) {
    error.value = err.message || '获取教师详情失败'
    console.error('教师详情加载失败:', err)
  } finally {
    loading.value = false
  }
}

// 页面加载时自动获取默认教师详情
onMounted(() => {
  loadTeacherDetail()
})
</script>

<style scoped>
.teacher-detail-demo {
  padding: 20rpx;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.header {
  background: white;
  padding: 30rpx;
  border-radius: 16rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
}

.title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
  display: block;
  margin-bottom: 20rpx;
}

.controls {
  display: flex;
  gap: 20rpx;
  align-items: center;
}

.input {
  flex: 1;
  padding: 16rpx;
  border: 2rpx solid #ddd;
  border-radius: 8rpx;
  font-size: 28rpx;
}

.load-btn {
  padding: 16rpx 32rpx;
  background: #007aff;
  color: white;
  border-radius: 8rpx;
  border: none;
  font-size: 28rpx;
}

.loading {
  text-align: center;
  padding: 60rpx;
  color: #666;
  background: white;
  border-radius: 16rpx;
}

.teacher-detail {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.teacher-info {
  background: white;
  border-radius: 16rpx;
  padding: 30rpx;
  display: flex;
  gap: 24rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
}

.avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 60rpx;
  flex-shrink: 0;
}

.info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 12rpx;
}

.name {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.description {
  font-size: 28rpx;
  color: #666;
}

.introduction {
  font-size: 26rpx;
  color: #888;
  line-height: 1.4;
}

.sort {
  font-size: 24rpx;
  color: #999;
}

.courses-section {
  background: white;
  border-radius: 16rpx;
  padding: 30rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
}

.section-title {
  font-size: 30rpx;
  font-weight: bold;
  color: #333;
  margin-bottom: 20rpx;
  display: block;
}

.courses-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.course-card {
  border: 2rpx solid #eee;
  border-radius: 12rpx;
  padding: 20rpx;
  display: flex;
  gap: 20rpx;
}

.course-cover {
  width: 100rpx;
  height: 100rpx;
  border-radius: 8rpx;
  flex-shrink: 0;
}

.course-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.course-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

.course-meta {
  display: flex;
  gap: 20rpx;
  align-items: center;
}

.course-type {
  font-size: 24rpx;
  color: #007aff;
  background: #e6f3ff;
  padding: 4rpx 12rpx;
  border-radius: 4rpx;
}

.course-price {
  font-size: 26rpx;
  color: #e74c3c;
  font-weight: bold;
}

.course-original-price {
  font-size: 22rpx;
  color: #999;
  text-decoration: line-through;
}

.course-students {
  font-size: 24rpx;
  color: #666;
}

.course-status {
  font-size: 22rpx;
  padding: 4rpx 12rpx;
  border-radius: 4rpx;
  width: fit-content;
}

.course-status.on-sale {
  background: #e8f5e8;
  color: #27ae60;
}

.course-status.off-sale {
  background: #fce8e8;
  color: #e74c3c;
}

.course-details {
  margin-top: 12rpx;
  padding-top: 12rpx;
  border-top: 1rpx solid #eee;
}

.details-title {
  font-size: 24rpx;
  color: #666;
  margin-bottom: 8rpx;
  display: block;
}

.details-content {
  font-size: 24rpx;
  color: #888;
  line-height: 1.4;
}

.no-courses {
  text-align: center;
  padding: 40rpx;
  color: #999;
  font-size: 26rpx;
}

.empty {
  text-align: center;
  padding: 60rpx;
  color: #999;
  background: white;
  border-radius: 16rpx;
}

.error {
  text-align: center;
  padding: 40rpx;
  background: white;
  border-radius: 16rpx;
}

.error-text {
  display: block;
  color: #e74c3c;
  font-size: 28rpx;
  margin-bottom: 20rpx;
}

.retry-btn {
  padding: 16rpx 32rpx;
  background: #007aff;
  color: white;
  border-radius: 8rpx;
  border: none;
  font-size: 28rpx;
}
</style>