<!-- 讲师标签页组件 -->
<script setup lang="ts">
import { computed } from 'vue'

// 定义标签页项接口
interface TabItem {
  title: string
  value: string
}

// 定义组件Props，提供默认值
interface Props {
  current: string
  list: TabItem[]
  theme?: 'primary' | 'secondary' | 'default'
  size?: 'small' | 'medium' | 'large'
}

const props = withDefaults(defineProps<Props>(), {
  theme: 'primary',
  size: 'medium',
})

// 定义组件Emits
interface Emits {
  (e: 'update:current', value: string): void
  (e: 'change', value: string): void
}

const emit = defineEmits<Emits>()

// 计算属性
const currentIndex = computed(() => 
  props.list.findIndex(item => item.value === props.current)
)

// 方法定义
/**
 * 处理标签页点击事件
 * @param item 标签页项
 * @param index 索引
 */
function handleTabClick(item: TabItem, index: number) {
  if (item.value !== props.current) {
    emit('update:current', item.value)
    emit('change', item.value)
  }
}

/**
 * 获取标签页样式类
 * @param index 索引
 * @returns 样式类名
 */
function getTabClass(index: number) {
  const isActive = index === currentIndex.value
  const baseClass = 'tab-item'
  const activeClass = isActive ? 'tab-item-active' : ''
  const sizeClass = `tab-item-${props.size}`
  const themeClass = `tab-item-${props.theme}`
  
  return `${baseClass} ${activeClass} ${sizeClass} ${themeClass}`
}
</script>

<template>
  <view class="instructor-tabs">
    <view class="tabs-container">
      <view
        v-for="(item, index) in list"
        :key="item.value"
        :class="getTabClass(index)"
        @click="handleTabClick(item, index)"
      >
        <text class="tab-text">{{ item.title }}</text>
        <view v-if="index === currentIndex" class="tab-indicator" />
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.instructor-tabs {
  border-bottom: 1px solid var(--border-primary);
}

.tabs-container {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 var(--spacing-md);
}

.tab-item {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--spacing-md) var(--spacing-lg);
  cursor: pointer;
  transition: all 0.3s ease;
  
  // 点击效果
  &:active {
    transform: scale(0.95);
  }
}

.tab-text {
  font-weight: 500;
  color: var(--text-secondary);
  transition: color 0.3s ease;
}

.tab-indicator {
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 40rpx;
  height: 4rpx;
  background-color: var(--primary-color);
  border-radius: 2rpx;
}

// 激活状态
.tab-item-active {
  .tab-text {
    color: var(--primary-color);
    font-weight: 600;
  }
}

// 尺寸变体
.tab-item-small {
  padding: var(--spacing-sm) var(--spacing-md);
  
  .tab-text {
    font-size: 24rpx;
  }
  
  .tab-indicator {
    width: 30rpx;
    height: 3rpx;
  }
}

.tab-item-medium {
  padding: var(--spacing-md) var(--spacing-lg);
  
  .tab-text {
    font-size: 28rpx;
  }
  
  .tab-indicator {
    width: 40rpx;
    height: 4rpx;
  }
}

.tab-item-large {
  padding: var(--spacing-lg) var(--spacing-xl);
  
  .tab-text {
    font-size: 32rpx;
  }
  
  .tab-indicator {
    width: 50rpx;
    height: 5rpx;
  }
}

// 主题变体
.tab-item-primary {
  .tab-indicator {
    background-color: var(--primary-color);
  }
  
  &.tab-item-active .tab-text {
    color: var(--primary-color);
  }
}

.tab-item-secondary {
  .tab-indicator {
    background-color: var(--secondary-color);
  }
  
  &.tab-item-active .tab-text {
    color: var(--secondary-color);
  }
}

.tab-item-default {
  .tab-indicator {
    background-color: var(--text-primary);
  }
  
  &.tab-item-active .tab-text {
    color: var(--text-primary);
  }
}
</style> 