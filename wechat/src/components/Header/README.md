# HeaderSimple 组件

## 功能特性

- 🎯 支持传递 title 进行居中显示
- 🔙 可选的返回按钮
- 👤 用户信息显示
- 🎛️ 右侧切换按钮
- 📍 底部插槽支持
- 🎨 使用主题色值系统

## 使用方法

### 基础用法（带标题）

```vue
<template>
  <HeaderSimple title="课程管理">
    <template #bottom>
      <SearchBar
        v-model="searchText"
        placeholder="搜索课程名称"
        @search="handleSearch"
      />
    </template>
  </HeaderSimple>
</template>

<script setup>
import { ref } from 'vue'

const searchText = ref('')

const handleSearch = (value) => {
  console.log('搜索内容:', value)
}
</script>
```

### 带返回按钮

```vue
<template>
  <HeaderSimple 
    title="课程详情" 
    :show-back="true"
    :show-right="false"
  />
</template>
```

### 默认样式（用户信息）

```vue
<template>
  <HeaderSimple title="首页" />
</template>
```

## Props

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| title | string | '' | 头部标题 |
| showBack | boolean | false | 是否显示返回按钮 |
| showRight | boolean | true | 是否显示右侧切换按钮 |

## Slots

| 插槽名 | 说明 |
|--------|------|
| bottom | 底部插槽，可以放置搜索框等内容 |

## 样式特点

- 使用项目统一的主题色值系统
- 支持深色主题切换
- 渐变背景效果
- 毛玻璃效果
- 响应式设计

## 布局结构

```
┌─────────────────────────────────────┐
│ 状态栏占位                          │
├─────────────────────────────────────┤
│ 左侧区域    中间标题    右侧区域      │
│ (返回/用户)  (居中)    (切换按钮)    │
├─────────────────────────────────────┤
│ 底部插槽                            │
│ (搜索框等)                          │
└─────────────────────────────────────┘
```

## 在项目中的使用

1. **课程管理页面** - 带搜索框的头部
2. **课程详情页面** - 带返回按钮的头部
3. **其他页面** - 根据需求配置 