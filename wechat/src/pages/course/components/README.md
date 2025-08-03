# 课程详情页面组件

## 组件结构

课程详情页面已拆分为以下组件，每个组件负责特定的功能模块：

### 1. CourseSwiper.vue - 课程轮播图组件
**功能**: 展示课程图片轮播
**Props**:
- `images: string[]` - 图片数组

**特点**:
- 自动播放轮播
- 指示器点
- 响应式设计

### 2. CourseInfo.vue - 课程信息组件
**功能**: 显示课程基本信息、价格、会员状态
**Props**:
- `title: string` - 课程标题
- `price: number` - 课程价格
- `studentCount: number` - 学习人数
- `isMember: boolean` - 会员状态

**特点**:
- 价格显示
- 会员免费标识
- 会员状态提示

### 3. CourseTabs.vue - 课程标签页组件
**功能**: 标签页切换
**Props**:
- `activeTab: number` - 当前激活的标签页
- `tabList: Array<{ title: string }>` - 标签页列表
- `isMember: boolean` - 会员状态

**Emits**:
- `update:activeTab` - 标签页切换事件

**特点**:
- 使用 sard-tabs 组件
- 主题色值配置
- 响应式切换

### 4. CourseContent.vue - 课程内容组件
**功能**: 显示不同标签页的内容
**Props**:
- `activeTab: number` - 当前激活的标签页
- `isMember: boolean` - 会员状态
- `description: string` - 课程描述
- `chapters: Chapter[]` - 课程章节
- `instructor: Instructor` - 讲师信息
- `materials: Material[]` - 课程资料

**Emits**:
- `download` - 下载资料事件

**特点**:
- 条件渲染不同内容
- 会员权限控制
- 资料下载功能

### 5. CourseActions.vue - 课程操作组件
**功能**: 底部操作按钮
**Props**:
- `isMember: boolean` - 会员状态

**Emits**:
- `action` - 主要操作事件

**特点**:
- 三个辅助按钮（首页、收藏、分享）
- 主要操作按钮（会员/非会员不同文案）
- 使用 sard-button 组件

## 接口定义

### Chapter 接口
```typescript
interface Chapter {
  title: string
  duration: string
}
```

### Instructor 接口
```typescript
interface Instructor {
  name: string
  title: string
  avatar: string
  bio: string
}
```

### Material 接口
```typescript
interface Material {
  name: string
  size: string
  url: string
}
```

## 使用方式

### 导入组件
```typescript
import {
  CourseSwiper,
  CourseInfo,
  CourseTabs,
  CourseContent,
  CourseActions,
} from './components'
```

### 在模板中使用
```vue
<template>
  <view class="course-detail">
    <CourseSwiper :images="courseDetail.images" />
    <CourseInfo
      :title="courseDetail.title"
      :price="courseDetail.price"
      :student-count="courseDetail.studentCount"
      :is-member="isMember"
    />
    <CourseTabs
      v-model:active-tab="activeTab"
      :tab-list="tabList"
      :is-member="isMember"
    />
    <CourseContent
      :active-tab="activeTab"
      :is-member="isMember"
      :description="courseDetail.description"
      :chapters="courseDetail.chapters"
      :instructor="courseDetail.instructor"
      :materials="courseDetail.materials"
      @download="handleDownload"
    />
    <CourseActions
      :is-member="isMember"
      @action="handleAction"
    />
  </view>
</template>
```

## 样式特点

### 主题色值
- 使用 CSS 变量系统
- 统一的视觉风格
- 响应式设计

### 组件样式
- 每个组件都有独立的样式作用域
- 使用 SCSS 预处理器
- 遵循设计规范

## 优化效果

### 代码组织
- ✅ 组件化拆分
- ✅ 职责单一
- ✅ 可复用性高
- ✅ 维护性增强

### 性能优化
- ✅ 减少主页面代码量
- ✅ 组件按需加载
- ✅ 样式隔离
- ✅ 事件处理优化

### 开发体验
- ✅ 代码结构清晰
- ✅ 组件接口明确
- ✅ 易于测试
- ✅ 便于扩展 