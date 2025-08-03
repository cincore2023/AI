<template>
  <view class="search-bar">
    <view class="search-input-wrapper">
      <text class="search-icon">🔍</text>
      <input
        v-model="searchValue"
        class="search-input"
        :placeholder="placeholder"
        @confirm="handleSearch"
        @input="handleInput"
      >
    </view>
    <view class="search-divider" />
    <text class="search-btn" @click="handleSearch">搜索</text>
  </view>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

// 定义 props
interface Props {
  modelValue?: string
  placeholder?: string
  showSearchBtn?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: '',
  placeholder: '搜索...',
  showSearchBtn: true
})

// 定义 emits
const emit = defineEmits<{
  'update:modelValue': [value: string]
  'search': [value: string]
  'input': [value: string]
}>()

// 响应式数据
const searchValue = ref(props.modelValue)

// 监听外部值变化
watch(() => props.modelValue, (newValue) => {
  searchValue.value = newValue
})

// 监听内部值变化
watch(searchValue, (newValue) => {
  emit('update:modelValue', newValue)
})

// 处理搜索
const handleSearch = () => {
  if (!searchValue.value.trim()) {
    uni.showToast({
      title: '请输入搜索内容',
      icon: 'none',
    })
    return
  }

  emit('search', searchValue.value.trim())
}

// 处理输入
const handleInput = () => {
  emit('input', searchValue.value)
}
</script>

<style lang="scss" scoped>
.search-bar {
  display: flex;
  align-items: center;
  background: var(--bg-primary);
  border-radius: var(--radius-lg);
  padding: 20rpx;
  border: 1rpx solid var(--border-primary);
  box-shadow: var(--shadow-sm);
}

.search-input-wrapper {
  flex: 1;
  display: flex;
  align-items: center;
}

.search-icon {
  font-size: 28rpx;
  color: var(--text-tertiary);
  margin-right: 16rpx;
}

.search-input {
  flex: 1;
  font-size: 28rpx;
  color: var(--text-primary);

  &::placeholder {
    color: var(--text-tertiary);
  }
}

.search-divider {
  width: 1rpx;
  height: 40rpx;
  background: var(--border-primary);
  margin: 0 20rpx;
}

.search-btn {
  font-size: 28rpx;
  color: var(--text-secondary);
  padding: 10rpx 20rpx;
}
</style> 