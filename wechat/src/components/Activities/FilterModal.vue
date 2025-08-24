<!-- 筛选弹窗组件 -->
<script setup lang="ts">
import { computed } from 'vue'

// 定义筛选选项接口
interface FilterOption {
  label: string
  value: string
}

// 定义组件Props，提供默认值
interface Props {
  visible: boolean
  title: string
  options: FilterOption[]
  selectedValue: string
  placeholder?: string
}

const props = withDefaults(defineProps<Props>(), {
  placeholder: '请选择',
})

// 定义组件Emits
interface Emits {
  (e: 'update:visible', value: boolean): void
  (e: 'select', value: string): void
}

const emit = defineEmits<Emits>()

// 计算属性
const hasOptions = computed(() => props.options && props.options.length > 0)

// 方法定义
/**
 * 处理弹窗关闭
 */
function handleClose() {
  emit('update:visible', false)
}

/**
 * 处理选项选择
 * @param value 选中的值
 */
function handleSelect(value: string) {
  emit('select', value)
  handleClose()
}

/**
 * 处理遮罩层点击
 */
function handleOverlayClick() {
  handleClose()
}
</script>

<template>
  <view v-if="visible" class="filter-modal" @click="handleOverlayClick">
    <view class="filter-content" @click.stop>
      <!-- 弹窗标题 -->
      <view class="filter-title">
        {{ title }}
      </view>
      
      <!-- 筛选选项 -->
      <view v-if="hasOptions" class="filter-options">
        <view
          v-for="option in options"
          :key="option.value"
          class="filter-option"
          :class="{ active: selectedValue === option.value }"
          @click="handleSelect(option.value)"
        >
          <text class="option-text">{{ option.label }}</text>
          <text v-if="selectedValue === option.value" class="option-check">✓</text>
        </view>
      </view>
      
      <!-- 空状态 -->
      <view v-else class="empty-options">
        <text class="empty-text">{{ placeholder }}</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.filter-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--bg-overlay);
  display: flex;
  align-items: flex-end;
  z-index: 1000;
}

.filter-content {
  width: 100%;
  background: var(--bg-primary);
  border-radius: 24rpx 24rpx 0 0;
  padding: 40rpx;
}

.filter-title {
  font-size: 32rpx;
  font-weight: bold;
  color: var(--text-primary);
  text-align: center;
  margin-bottom: 40rpx;
}

.filter-options {
  .filter-option {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30rpx 0;
    border-bottom: 2rpx solid var(--border-secondary);
    cursor: pointer;
    transition: background-color 0.2s ease;
    
    &:last-child {
      border-bottom: none;
    }
    
    &:active {
      background-color: var(--bg-secondary);
    }
    
    .option-text {
      font-size: 30rpx;
      color: var(--text-primary);
    }
    
    .option-check {
      font-size: 30rpx;
      color: var(--primary-color);
      font-weight: bold;
    }
    
    &.active {
      .option-text {
        color: var(--primary-color);
        font-weight: 500;
      }
    }
  }
}

.empty-options {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60rpx 0;
  
  .empty-text {
    font-size: 28rpx;
    color: var(--text-tertiary);
  }
}
</style>

