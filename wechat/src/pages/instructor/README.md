# 讲师详情页

## 功能概述

讲师详情页是一个完整的讲师信息展示页面，包含讲师基本信息、课程列表和详细简介。页面采用组件化设计，具有良好的可维护性和扩展性。

## 页面结构

```
src/pages/instructor/
├── detail.vue          # 讲师详情主页面
└── README.md           # 说明文档

src/components/Instructor/
├── InstructorProfile.vue   # 讲师信息卡片组件
├── InstructorTabs.vue      # 标签页组件
├── CourseList.vue          # 课程列表组件
├── InstructorBio.vue       # 讲师简介组件
└── index.ts               # 组件导出文件
```

## 主要功能

### 1. 讲师信息展示
- 讲师头像、姓名、职位
- 工作经验
- 专业领域标签
- 个人简介

### 2. 课程管理
- 课程列表展示
- 课程详情跳转
- 课程分类筛选

### 3. 交互功能
- 标签页切换（课程/简介）
- 课程点击跳转
- 专业领域点击搜索
- 联系讲师功能

## 组件说明

### InstructorProfile.vue
讲师信息卡片组件，展示讲师的基本信息。

**Props:**
- `instructor: Instructor` - 讲师信息对象
- `showSpecialties?: boolean` - 是否显示专业领域（默认：true）
- `showExperience?: boolean` - 是否显示工作经验（默认：true）

**Events:**
- `click` - 卡片点击事件

### InstructorTabs.vue
标签页组件，用于切换课程和简介。

**Props:**
- `current: string` - 当前激活的标签页
- `list: TabItem[]` - 标签页列表
- `theme?: 'primary' | 'secondary' | 'default'` - 主题色（默认：primary）
- `size?: 'small' | 'medium' | 'large'` - 尺寸（默认：medium）

**Events:**
- `update:current` - 更新当前标签页
- `change` - 标签页切换事件

### CourseList.vue
课程列表组件，展示讲师的课程。

**Props:**
- `courses: Course[]` - 课程列表
- `layout?: 'grid' | 'list'` - 布局方式（默认：list）
- `showEmpty?: boolean` - 是否显示空状态（默认：true）
- `emptyText?: string` - 空状态文本（默认：暂无课程）

**Events:**
- `courseClick` - 课程点击事件
- `emptyClick` - 空状态点击事件

### InstructorBio.vue
讲师简介组件，展示讲师的详细信息。

**Props:**
- `instructor: Instructor` - 讲师信息对象
- `showAvatar?: boolean` - 是否显示头像（默认：true）
- `showSpecialties?: boolean` - 是否显示专业领域（默认：true）
- `showExperience?: boolean` - 是否显示工作经验（默认：true）
- `maxSpecialties?: number` - 最大显示专业领域数量（默认：5）

**Events:**
- `specialtyClick` - 专业领域点击事件
- `contactClick` - 联系讲师事件

## 数据接口

### Instructor 接口
```typescript
interface Instructor {
  id: string
  name: string
  title: string
  avatar: string
  bio?: string
  experience?: string
  specialties?: string[]
  courses: Course[]
}
```

### Course 接口
```typescript
interface Course {
  id: string
  title: string
  image: string
  type: string
  learners: number
  price: string | number
  description: string
}
```

## 使用方法

### 1. 页面跳转
```typescript
// 从首页跳转到讲师详情页
uni.navigateTo({
  url: `/pages/instructor/detail?id=${instructorId}`
})
```

### 2. 组件使用
```vue
<template>
  <InstructorProfile 
    :instructor="instructorData"
    @click="handleInstructorClick"
  />
  
  <InstructorTabs
    v-model:current="activeTab"
    :list="tabList"
    @change="handleTabChange"
  />
  
  <CourseList
    :courses="courses"
    @course-click="handleCourseClick"
  />
  
  <InstructorBio
    :instructor="instructorData"
    @specialty-click="handleSpecialtyClick"
    @contact-click="handleContactClick"
  />
</template>
```

## 样式规范

### 颜色变量
页面使用CSS变量进行主题管理：
- `--primary-color` - 主色调
- `--text-primary` - 主要文本色
- `--text-secondary` - 次要文本色
- `--bg-primary` - 主要背景色
- `--bg-secondary` - 次要背景色

### 间距规范
- `--spacing-xs` - 超小间距（8rpx）
- `--spacing-sm` - 小间距（16rpx）
- `--spacing-md` - 中等间距（24rpx）
- `--spacing-lg` - 大间距（32rpx）
- `--spacing-xl` - 超大间距（48rpx）

## 错误处理

页面包含完善的错误处理机制：
- 数据加载失败处理
- 页面跳转失败处理
- 组件交互错误处理
- 网络请求异常处理

## 性能优化

- 使用计算属性优化渲染性能
- 组件懒加载
- 图片加载错误处理
- 响应式设计适配不同屏幕

## 扩展功能

### 可扩展的功能点
1. 讲师评价系统
2. 课程收藏功能
3. 讲师关注功能
4. 课程推荐算法
5. 在线咨询功能

### 国际化支持
组件支持多语言配置，可通过props传入语言包。

## 注意事项

1. 确保所有Props都有类型定义和默认值
2. 使用setup语法糖编写组件
3. 遵循Vue官方风格指南
4. 充分使用sard-uniapp组件库
5. 保持UI风格统一
6. 完善错误处理和用户反馈 