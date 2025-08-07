<script setup lang="ts">
interface Instructor {
  id: string
  name: string
  title: string
  avatar: string
}

// 讲师数据
const instructors = ref<Instructor[]>([
  {
    id: '1',
    name: '张教授',
    title: '抖迅AI商学院院长',
    avatar: 'https://picsum.photos/100/100?random=10',
  },
  {
    id: '2',
    name: '张教授',
    title: '抖迅AI商学院院长',
    avatar: 'https://picsum.photos/100/100?random=11',
  },
  {
    id: '3',
    name: '张教授',
    title: '抖迅AI商学院院长',
    avatar: 'https://picsum.photos/100/100?random=12',
  },
  {
    id: '4',
    name: '张教授',
    title: '抖迅AI商学院院长',
    avatar: 'https://picsum.photos/100/100?random=13',
  },
  {
    id: '5',
    name: '李教授',
    title: '资深技术专家',
    avatar: 'https://picsum.photos/100/100?random=14',
  },
])

/**
 * 处理讲师点击事件
 * @param instructor 讲师信息
 */
function handleInstructorClick(instructor: Instructor) {
  try {
    console.log('点击讲师:', instructor.name)
    
    // 跳转到讲师详情页
    uni.navigateTo({
      url: `/pages/instructor/detail?id=${instructor.id}`,
      fail: (err) => {
        console.error('跳转失败:', err)
        uni.showToast({
          title: '页面跳转失败',
          icon: 'error',
        })
      },
    })
  } catch (err) {
    console.error('讲师点击处理失败:', err)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}

/**
 * 处理查看全部讲师事件
 */
function handleViewAll() {
  try {
    console.log('查看全部讲师')
    
    // 跳转到讲师列表页或搜索页
    uni.navigateTo({
      url: '/pages/instructor/list',
      fail: (err) => {
        console.error('跳转失败:', err)
        uni.showToast({
          title: '页面跳转失败',
          icon: 'error',
        })
      },
    })
  } catch (err) {
    console.error('查看全部讲师处理失败:', err)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}
</script>

<template>
  <view class="instructor-section">
    <view class="section-header mb-4 flex items-center justify-between">
      <text class="section-title text-lg font-bold">讲师团队</text>
      <view class="view-all-btn rounded-full px-3 py-1 text-sm" @click="handleViewAll">
        查看全部
      </view>
    </view>

    <scroll-view
      class="instructors-scroll"
      :scroll-x="true"
      :show-scrollbar="false"
      enhanced="true"
    >
      <view class="instructors-container flex">
        <view
          v-for="instructor in instructors"
          :key="instructor.id"
          class="instructor-item mr-6 min-w-20 flex flex-col items-center"
          @click="handleInstructorClick(instructor)"
        >
          <!-- 讲师头像 -->
          <view class="instructor-avatar mb-2">
            <image
              :src="instructor.avatar"
              class="h-16 w-16 rounded-full object-cover"
            />
          </view>

          <!-- 讲师信息 -->
          <view class="instructor-info flex flex-col text-center">
            <text class="instructor-name text-base font-medium">{{ instructor.name }}</text>
            <text class="instructor-title mt-1">{{ instructor.title }}</text>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.instructor-section {
  padding-bottom: 40rpx;
}

.section-title {
  font-size: 40rpx;
  color: var(--text-primary);
}

.view-all-btn {
  font-size: 28rpx;
  font-weight: 500;
  background-color: var(--primary-color);
  color: var(--text-inverse);
  transition: all 0.3s ease;

  &:active {
    transform: scale(0.95);
    background-color: var(--primary-dark);
  }
}

.instructors-container {
  display: flex;
  align-items: center;
}

.instructor-item {
  // 点击效果
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.95);
  }

  &:last-child {
    margin-right: 0;
  }
}

.instructor-avatar {
  position: relative;
}

.instructor-info {
  min-width: 80rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 80rpx;
}

.instructor-name {
  font-size: 32rpx;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  color: var(--text-primary);
}

.instructor-title {
  font-size: 24rpx;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  color: var(--text-secondary);
}
</style>
