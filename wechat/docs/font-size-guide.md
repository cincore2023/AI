# 字体大小统一指南

## 📋 概述

本文档记录了首页字体大小的调整，使其与个人中心保持一致，提升整体用户体验和视觉统一性。

## 🎯 调整目标

- 统一首页与个人中心的字体大小
- 提升文字可读性
- 保持视觉层次分明
- 优化用户体验

## 📊 字体大小对比表

### 调整前后对比

| 组件 | 元素类型 | 调整前 | 调整后 | 个人中心参考 | 变化 |
|------|----------|--------|--------|-------------|------|
| 推荐课程 | 标题 | 36rpx | 40rpx | 40rpx | +4rpx |
| 精选课程 | 标题 | 36rpx | 40rpx | 40rpx | +4rpx |
| 讲师团队 | 标题 | 36rpx | 40rpx | 40rpx | +4rpx |
| 课程卡片 | 课程标题 | 28rpx | 32rpx | 32rpx | +4rpx |
| 课程卡片 | 学习人数 | 24rpx | 28rpx | 28rpx | +4rpx |
| 课程卡片 | 价格 | 28rpx | 32rpx | 32rpx | +4rpx |
| 课程卡片 | 类型标签 | 20rpx | 24rpx | 24rpx | +4rpx |
| 讲师团队 | 讲师姓名 | 28rpx | 32rpx | 32rpx | +4rpx |
| 讲师团队 | 讲师职称 | 20rpx | 24rpx | 24rpx | +4rpx |
| 讲师团队 | 查看全部按钮 | 24rpx | 28rpx | 28rpx | +4rpx |

## 🎨 字体大小规范

### 标题级别
- **页面主标题**: 40rpx (text-xl)
- **区块标题**: 40rpx (text-xl)
- **卡片标题**: 32rpx (text-base)

### 正文级别
- **主要文字**: 32rpx (text-base)
- **次要文字**: 28rpx (text-sm)
- **辅助文字**: 24rpx (text-xs)

### 按钮级别
- **主要按钮**: 28rpx (text-sm)
- **次要按钮**: 24rpx (text-xs)

## 📁 修改的文件

### 1. 推荐课程组件
**文件**: `src/components/Home/RecommendedSection.vue`
```vue
<!-- 修改前 -->
<text class="section-title text-lg font-bold">推荐</text>

<!-- 修改后 -->
<text class="section-title text-xl font-bold">推荐</text>
```

### 2. 精选课程组件
**文件**: `src/components/Home/FeaturedCoursesSection.vue`
```vue
<!-- 修改前 -->
<text class="section-title text-lg font-bold">精选课程</text>

<!-- 修改后 -->
<text class="section-title text-xl font-bold">精选课程</text>
```

### 3. 讲师团队组件
**文件**: `src/components/Home/InstructorTeamSection.vue`
```vue
<!-- 修改前 -->
<text class="section-title text-lg font-bold">讲师团队</text>
<text class="instructor-name text-sm font-medium">{{ instructor.name }}</text>
<view class="view-all-btn rounded-full px-3 py-1 text-xs">

<!-- 修改后 -->
<text class="section-title text-xl font-bold">讲师团队</text>
<text class="instructor-name text-base font-medium">{{ instructor.name }}</text>
<view class="view-all-btn rounded-full px-3 py-1 text-sm">
```

### 4. 课程卡片组件
**文件**: `src/components/Home/CourseCard.vue`
```vue
<!-- 修改前 -->
<text class="course-title line-clamp-2 text-sm font-medium">{{ course.title }}</text>
<text class="learners text-xs">{{ course.learners }}人学习</text>
<text class="price text-sm font-bold">

<!-- 修改后 -->
<text class="course-title line-clamp-2 text-base font-medium">{{ course.title }}</text>
<text class="learners text-sm">{{ course.learners }}人学习</text>
<text class="price text-base font-bold">
```

## 🎯 统一效果

### 视觉层次
1. **主标题** (40rpx): 页面和区块标题
2. **副标题** (32rpx): 卡片标题、重要信息
3. **正文** (28rpx): 一般描述文字
4. **辅助信息** (24rpx): 标签、备注等

### 用户体验提升
- ✅ **更好的可读性**: 字体更大，阅读更舒适
- ✅ **视觉统一性**: 与个人中心风格保持一致
- ✅ **层次分明**: 标题、正文、辅助信息有清晰的层次
- ✅ **专业感**: 整体视觉效果更加协调

## 📝 注意事项

1. **保持一致性**: 新添加的组件应遵循此字体大小规范
2. **响应式考虑**: 在不同设备上保持良好的显示效果
3. **可访问性**: 确保字体大小符合可访问性标准
4. **性能优化**: 避免过度使用大字体影响性能

## 🔄 更新记录

| 日期 | 版本 | 更新内容 | 负责人 |
|------|------|----------|--------|
| 2024-01-XX | v1.0 | 初始字体大小统一调整 | AI Assistant |

## 📞 联系方式

如有疑问或建议，请联系开发团队。 