# 课程管理功能

## 功能概述

课程管理功能提供了完整的课程浏览和详情查看功能，包括：

- 课程列表展示
- 课程搜索和筛选
- 课程详情查看
- 会员功能体验
- 课程状态管理

## 页面结构

### 1. 课程列表页面 (`index.vue`)

**功能特性：**
- 头部组件：使用 `HeaderSimple` 组件，支持标题显示和底部插槽
- 搜索功能：在头部底部插槽中使用 `SearchBar` 组件
- 侧边栏分类：使用 `sar-sidebar` 组件进行分类筛选
- 课程卡片：展示课程图片、标题、描述、学习人数、价格
- 主题色值：使用项目统一的主题色值系统

**分类选项：**
- 全部
- 软件开发
- AI赋能
- 设计
- 营销
- 商业
- 已发布
- 未发布
- 草稿

### 2. 课程详情页面 (`detail.vue`)

**功能特性：**
- 头部组件：使用 `HeaderSimple` 组件，带返回按钮
- 课程图片展示
- 课程基本信息（标题、价格、学习人数）
- 会员状态显示
- 标签页切换（预览/详情、讲师、资料）
- 底部操作栏（首页、收藏、分享、观看按钮）
- 主题色值：使用项目统一的主题色值系统

**会员功能：**
- 非会员用户：显示"预览"标签，内容受限
- 会员用户：显示"详情"标签，可查看完整内容
- 会员状态提示：黄色提示非会员，绿色提示会员
- 资料下载：会员专享功能

**iOS 支付限制：**
- 检测iOS设备并显示支付限制提示
- 符合微信小程序审核要求

**标签页内容：**
- 预览/详情：课程简介、课程大纲
- 讲师：讲师头像、姓名、职称、简介
- 资料：可下载的学习资料列表



## API 接口

课程管理相关的 API 接口定义在 `src/api/course.ts` 中：

- `getCourseList()` - 获取课程列表
- `getCourseDetail()` - 获取课程详情
- `createCourse()` - 创建课程
- `updateCourse()` - 更新课程
- `deleteCourse()` - 删除课程
- `updateCourseStatus()` - 更新课程状态
- `uploadCourseImage()` - 上传课程图片

## 数据结构

### Course 接口
```typescript
interface Course {
  id: string
  title: string
  description: string
  image: string
  price: number
  studentCount: number
  status: 'active' | 'inactive' | 'draft'
  category: string
  createdAt: string
  updatedAt: string
}
```

## 使用说明

1. **查看课程列表**：在底部导航栏点击"课程管理"进入课程列表页面
2. **搜索课程**：在顶部搜索栏输入关键词进行搜索
3. **分类筛选**：使用左侧边栏按分类或状态筛选课程
4. **查看课程详情**：点击课程卡片进入详情页面
5. **会员功能**：在详情页面可以开通会员或查看会员专享内容

## 样式特点

- 采用现代化的卡片式设计
- 响应式布局，适配不同屏幕尺寸
- 使用项目统一的主题色值系统
- 良好的视觉层次和间距
- 流畅的交互动画
- 支持深色主题切换

## 技术栈

- Vue 3 Composition API
- TypeScript
- SCSS 主题色值系统
- uni-app 框架
- Pinia 状态管理
- sard-uniapp 组件库
- 自定义组件库（SearchBar、HeaderSimple）
- 响应式设计 