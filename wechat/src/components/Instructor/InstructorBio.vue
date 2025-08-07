<!-- 讲师简介组件 -->
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
  showAvatar?: boolean
  showSpecialties?: boolean
  showExperience?: boolean
  maxSpecialties?: number
}

const props = withDefaults(defineProps<Props>(), {
  showAvatar: true,
  showSpecialties: true,
  showExperience: true,
  maxSpecialties: 5,
})

const emit = defineEmits<Emits>()

// 定义组件Emits
interface Emits {
  (e: 'specialtyClick', specialty: string): void
  (e: 'contactClick'): void
}

// 计算属性
const hasBio = computed(() => props.instructor.bio && props.instructor.bio.trim().length > 0)

const hasExperience = computed(() =>
  props.showExperience && props.instructor.experience && props.instructor.experience.trim().length > 0,
)

const hasSpecialties = computed(() =>
  props.showSpecialties && props.instructor.specialties && props.instructor.specialties.length > 0,
)

const displaySpecialties = computed(() => {
  if (!hasSpecialties.value)
    return []
  return props.instructor.specialties!.slice(0, props.maxSpecialties)
})

const hasMoreSpecialties = computed(() =>
  props.instructor.specialties && props.instructor.specialties.length > props.maxSpecialties,
)

// 方法定义
/**
 * 处理专业领域点击事件
 * @param specialty 专业领域
 */
function handleSpecialtyClick(specialty: string) {
  try {
    console.log('点击专业领域:', specialty)
    emit('specialtyClick', specialty)

    // 可以跳转到相关课程或搜索
    uni.showToast({
      title: `查看${specialty}相关课程`,
      icon: 'none',
    })
  }
  catch (err) {
    console.error('专业领域点击处理失败:', err)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}

/**
 * 处理联系讲师事件
 */
function handleContactClick() {
  try {
    console.log('联系讲师:', props.instructor.name)
    emit('contactClick')

    uni.showToast({
      title: '正在为您联系讲师...',
      icon: 'none',
    })
  }
  catch (err) {
    console.error('联系讲师处理失败:', err)
    uni.showToast({
      title: '操作失败',
      icon: 'error',
    })
  }
}

/**
 * 处理头像加载错误
 */
function handleAvatarError() {
  console.warn('讲师头像加载失败:', props.instructor.avatar)
}
</script>

<template>
  <view class="instructor-bio">
    <!-- 讲师头像和基本信息 -->
    <view v-if="showAvatar" class="bio-header">
      <view class="avatar-section">
        <image
          :src="instructor.avatar"
          class="bio-avatar"
          mode="aspectFill"
          @error="handleAvatarError"
        />
      </view>
      <view class="basic-info">
        <text class="bio-name">{{ instructor.name }}</text>
        <text class="bio-title">{{ instructor.title }}</text>
      </view>
    </view>

    <!-- 讲师简介 -->
    <view v-if="hasBio" class="bio-section">
      <view class="section-header">
        <text class="section-title">个人简介</text>
      </view>
      <view class="bio-content">
        <text class="bio-text">{{ instructor.bio }}</text>
      </view>
    </view>

    <!-- 工作经验 -->
    <view v-if="hasExperience" class="experience-section">
      <view class="section-header">
        <text class="section-title">工作经验</text>
      </view>
      <view class="experience-content">
        <text class="experience-text">{{ instructor.experience }}</text>
      </view>
    </view>

    <!-- 专业领域 -->
    <view v-if="hasSpecialties" class="specialties-section">
      <view class="section-header">
        <text class="section-title">专业领域</text>
      </view>
      <view class="specialties-content">
        <view class="specialties-grid">
          <sar-tag
            v-for="specialty in displaySpecialties"
            :key="specialty"
            size="medium"
            theme="primary"
            class="specialty-tag"
            @click="handleSpecialtyClick(specialty)"
          >{{specialty}}</sar-tag>
        </view>
        <text v-if="hasMoreSpecialties" class="more-specialties">
          还有 {{ instructor.specialties!.length - maxSpecialties }} 个专业领域...
        </text>
      </view>
    </view>

    <!-- 联系讲师 -->
    <view class="contact-section">
      <sar-button
        type="solid"
        theme="primary"
        size="large"
        class="contact-button"
        @click="handleContactClick"
      >
        联系讲师
      </sar-button>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.instructor-bio {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-lg);
}

.bio-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  padding: var(--spacing-md);
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
}

.avatar-section {
  flex-shrink: 0;
}

.bio-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  border: 2rpx solid var(--border-primary);
}

.basic-info {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-xs);
}

.bio-name {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
}

.bio-title {
  font-size: 24rpx;
  color: var(--text-secondary);
}

.section-header {
  margin-bottom: var(--spacing-sm);
}

.section-title {
  font-size: 28rpx;
  font-weight: 600;
  color: var(--text-primary);
  position: relative;
  padding-left: var(--spacing-sm);

  &::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 6rpx;
    height: 24rpx;
    background-color: var(--primary-color);
    border-radius: 3rpx;
  }
}

.bio-section,
.experience-section,
.specialties-section {
  background-color: var(--bg-primary);
  border-radius: var(--radius-md);
  padding: var(--spacing-md);
  box-shadow: var(--shadow-sm);
}

.bio-content,
.experience-content {
  line-height: 1.6;
}

.bio-text,
.experience-text {
  font-size: 28rpx;
  color: var(--text-secondary);
  line-height: 1.6;
}

.specialties-content {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-sm);
}

.specialties-grid {
  display: flex;
  flex-wrap: wrap;
  gap: var(--spacing-sm);
}

.specialty-tag {
  cursor: pointer;
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.95);
  }
}

.more-specialties {
  font-size: 24rpx;
  color: var(--text-tertiary);
  font-style: italic;
}

.contact-section {
  display: flex;
  justify-content: center;
  padding: var(--spacing-md) 0;
}

.contact-button {
  width: 100%;
  max-width: 400rpx;
  border-radius: var(--radius-lg);
  font-weight: 600;

  // 点击效果
  transition: transform 0.2s ease;

  &:active {
    transform: scale(0.98);
  }
}
</style>
