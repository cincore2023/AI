# SearchBar 搜索框组件

## 功能特性

- 🔍 统一的搜索框样式
- 📱 支持 v-model 双向绑定
- 🎨 使用主题色值系统
- ⚡ 支持搜索和输入事件
- 🎯 可自定义占位符文本

## 使用方法

### 基础用法

```vue
<template>
  <SearchBar
    v-model="searchText"
    placeholder="搜索课程名称"
    @search="handleSearch"
  />
</template>

<script setup>
import { SearchBar } from '@/components/SearchBar'
import { ref } from 'vue'

const searchText = ref('')

const handleSearch = (value) => {
  console.log('搜索内容:', value)
}
</script>
```

### Props

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| modelValue | string | '' | 搜索框的值 |
| placeholder | string | '搜索...' | 占位符文本 |
| showSearchBtn | boolean | true | 是否显示搜索按钮 |

### Events

| 事件名 | 参数 | 说明 |
|--------|------|------|
| update:modelValue | value: string | 值变化时触发 |
| search | value: string | 点击搜索按钮时触发 |
| input | value: string | 输入时触发 |

## 样式特点

- 使用项目统一的主题色值系统
- 支持深色主题切换
- 响应式设计
- 现代化的视觉风格

## 在项目中的使用

1. **HeaderWithSearch.vue** - 头部搜索框
2. **课程管理页面** - 课程搜索功能
3. **其他需要搜索的页面** - 可复用组件 