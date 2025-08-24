<template>
  <view class="teacher-demo">
    <view class="header">
      <text class="title">教师列表演示</text>
      <view class="sort-controls">
        <button @click="changeSort('desc')" :class="['sort-btn', { active: sortType === 'desc' }]">
          降序
        </button>
        <button @click="changeSort('asc')" :class="['sort-btn', { active: sortType === 'asc' }]">
          升序
        </button>
      </view>
    </view>

    <view class="loading" v-if="loading">
      <text>加载中...</text>
    </view>

    <view class="teacher-list" v-else>
      <view class="teacher-card" v-for="teacher in teachers" :key="teacher.id">
        <image class="avatar" :src="teacher.avatar" mode="aspectFill" />
        <view class="info">
          <text class="name">{{ teacher.name }}</text>
          <text class="description">{{ teacher.description }}</text>
          <view class="introduction" v-html="teacher.introduction"></view>
          <text class="sort">排序: {{ teacher.sort }}</text>
        </view>
      </view>
    </view>

    <view class="empty" v-if="!loading && teachers.length === 0">
      <text>暂无教师数据</text>
    </view>

    <view class="error" v-if="error">
      <text class="error-text">{{ error }}</text>
      <button @click="loadTeachers" class="retry-btn">重试</button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getTeachers } from '@/api/teacher'
import type { ITeacherItem } from '@/api/types/teacher'

const teachers = ref<ITeacherItem[]>([])
const loading = ref(false)
const error = ref('')
const sortType = ref<'asc' | 'desc'>('desc')

const loadTeachers = async () => {
  try {
    loading.value = true
    error.value = ''
    
    const response = await getTeachers(sortType.value)
    teachers.value = response.teachers || []
    
    console.log('教师数据加载成功:', teachers.value)
  } catch (err: any) {
    error.value = err.message || '获取教师列表失败'
    console.error('教师数据加载失败:', err)
  } finally {
    loading.value = false
  }
}

const changeSort = (sort: 'asc' | 'desc') => {
  sortType.value = sort
  loadTeachers()
}

onMounted(() => {
  loadTeachers()
})
</script>

<style scoped>
.teacher-demo {
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

.sort-controls {
  display: flex;
  gap: 20rpx;
}

.sort-btn {
  padding: 16rpx 32rpx;
  border: 2rpx solid #007aff;
  border-radius: 8rpx;
  background: white;
  color: #007aff;
  font-size: 28rpx;
}

.sort-btn.active {
  background: #007aff;
  color: white;
}

.loading {
  text-align: center;
  padding: 60rpx;
  color: #666;
}

.teacher-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.teacher-card {
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