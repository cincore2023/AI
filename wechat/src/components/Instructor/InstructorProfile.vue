<!-- 讲师信息卡片组件 -->
<script setup lang="ts">
import { computed } from 'vue'

// 定义讲师信息接口
interface Instructor {
  id: string
  name: string
  title: string
  avatar: string
  bio?: string
  experience?: string
  specialties?: string[]
}

// 定义组件Props，提供默认值
interface Props {
  instructor: Instructor
  showSpecialties?: boolean
  showExperience?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  showSpecialties: true,
  showExperience: true,
})

// 定义组件Emits
interface Emits {
  (e: 'click', instructor: Instructor): void
}

const emit = defineEmits<Emits>()

// 计算属性
const hasSpecialties = computed(() => 
  props.showSpecialties && props.instructor.specialties && props.instructor.specialties.length > 0
)

const hasExperience = computed(() => 
  props.showExperience && props.instructor.experience
)

// 方法定义
/**
 * 处理卡片点击事件
 */
function handleCardClick() {
  emit('click', props.instructor)
}

/**
 * 处理头像加载错误
 */
function handleAvatarError() {
  console.warn('讲师头像加载失败:', props.instructor.avatar)
  // 可以设置默认头像
}
</script>

<template>
  <view class="instructor-profile-card" @click="handleCardClick">
    <!-- 背景装饰 -->
    <view class="profile-background" />
    
    <!-- 主要内容 -->
    <view class="profile-content">
      <!-- 讲师头像 -->
      <view class="avatar-section">
        <image
          :src="instructor.avatar"
          class="instructor-avatar"
          mode="aspectFill"
          @error="handleAvatarError"
        />
      </view>
      
      <!-- 讲师基本信息 -->
      <view class="info-section">
        <text class="instructor-name">{{ instructor.name }}</text>
        <text class="instructor-title">{{ instructor.title }}</text>
        
        <!-- 工作经验 -->
        <view v-if="hasExperience" class="experience-section">
          <text class="experience-label">工作经验:</text>
          <text class="experience-value">{{ instructor.experience }}</text>
        </view>
      </view>
      
      <!-- 专业领域 -->
      <view v-if="hasSpecialties" class="specialties-section">
        <text class="specialties-label">专业领域:</text>
        <view class="specialties-tags">
          <sar-tag
            v-for="specialty in instructor.specialties"
            :key="specialty"
            :text="specialty"
            size="small"
            theme="primary"
            class="specialty-tag"
          />
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.instructor-profile-card {
  position: relative;
  background-color: var(--bg-primary);
  border-radius: var(--radius-lg);
  margin-bottom: var(--spacing-md);
  padding: var(--spacing-lg);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  
  // 点击效果
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  
  &:active {
    transform: scale(0.98);
    box-shadow: var(--shadow-md);
  }
}

.profile-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 120rpx;
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
  opacity: 0.1;
}

.profile-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.avatar-section {
  margin-bottom: var(--spacing-md);
}

.instructor-avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  border: 4rpx solid var(--bg-primary);
  box-shadow: var(--shadow-sm);
}

.info-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: var(--spacing-md);
  text-align: center;
}

.instructor-name {
  font-size: 36rpx;
  font-weight: bold;
  color: var(--text-primary);
  margin-bottom: var(--spacing-xs);
}

.instructor-title {
  font-size: 28rpx;
  color: var(--text-secondary);
  margin-bottom: var(--spacing-sm);
}

.experience-section {
  display: flex;
  align-items: center;
  gap: var(--spacing-xs);
  margin-top: var(--spacing-xs);
}

.experience-label {
  font-size: 24rpx;
  color: var(--text-tertiary);
}

.experience-value {
  font-size: 24rpx;
  color: var(--text-secondary);
  font-weight: 500;
}

.specialties-section {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.specialties-label {
  font-size: 24rpx;
  color: var(--text-tertiary);
  margin-bottom: var(--spacing-xs);
}

.specialties-tags {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-xs);
  justify-content: center;
}

.specialty-tag {
  margin: 0;
}
</style> 