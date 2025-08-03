# 个人中心页面

## 功能概述

个人中心页面是用户管理个人信息、查看会员状态、使用各种服务以及管理合伙人功能的核心页面。

## 主要功能模块

### 1. 用户信息区域
- **头像显示**: 显示用户头像
- **昵称管理**: 显示微信昵称，支持修改
- **手机号码**: 显示脱敏的手机号码
- **VIP状态**: 显示会员状态和到期时间

### 2. 我的服务
- **服务网格**: 3x2 网格布局展示各种服务
- **服务项目**:
  - 我的活动
  - 我的课程
  - 我的素材
  - 我的智能体
  - 联系客服
  - 教程中心
- **销售专员绑定**: 支持绑定销售专员

### 3. 合伙人中心
- **收入概览**:
  - 可提现收入
  - 累计收入
- **详细统计**:
  - 我的团队人数
  - 提现中金额
  - 已提现金额
  - 推广码生成
  - 会员兑换码
  - 活动兑换码

## 技术特性

### 组件使用
- `HeaderSimple`: 自定义头部组件
- 响应式设计: 适配不同屏幕尺寸
- 主题色值: 使用 CSS 变量系统

### 状态管理
- `useMemberStore`: 会员状态管理
- 响应式数据: 用户信息、合伙人数据

### 交互功能
- 模态框: 昵称修改、续费确认等
- 页面跳转: 服务页面导航
- Toast 提示: 操作反馈

## 样式特点

### 布局设计
- 卡片式布局
- 清晰的信息层次
- 现代化的视觉设计

### 颜色方案
- 使用主题色值变量
- 高对比度设计
- 统一的视觉风格

### 响应式
- 适配移动端
- 弹性布局
- 合理的间距设计

## 数据接口

### 用户信息
```typescript
interface UserInfo {
  nickname: string
  phone: string
  avatar: string
  memberExpireDate: string
}
```

### 服务项目
```typescript
interface ServiceItem {
  icon: string
  title: string
  path: string
}
```

### 合伙人信息
```typescript
interface PartnerInfo {
  withdrawableIncome: number
  totalIncome: number
  teamCount: number
  withdrawing: number
  withdrawn: number
  memberCode: number
  activityCode: number
}
```

## 页面路由

- **路径**: `/pages/personal/index`
- **布局**: `tabbar`
- **导航**: 自定义导航栏

## 注意事项

1. 会员状态需要与后端 API 同步
2. 用户信息修改需要保存到本地或后端
3. 合伙人数据需要实时更新
4. 服务页面跳转需要确保目标页面存在 