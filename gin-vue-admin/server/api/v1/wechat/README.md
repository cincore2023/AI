# 微信小程序模块

本目录包含了所有微信小程序相关的API和路由实现，是一个独立的模块，与系统管理模块平级。

## 目录结构

```
gin-vue-admin/server/
├── api/v1/
│   ├── system/          # 系统管理模块
│   ├── example/         # 示例模块
│   └── wechat/          # 微信小程序模块（新）
│       ├── auth.go      # 微信登录认证相关API
│       ├── banner.go    # 微信轮播图相关API  
│       └── enter.go     # 模块入口文件
└── router/
    ├── system/          # 系统管理路由
    ├── example/         # 示例路由
    └── wechat/          # 微信小程序路由（新）
        ├── auth.go      # 微信认证路由
        ├── banner.go    # 微信轮播图路由
        └── enter.go     # 路由入口文件
```

## 功能模块

### 1. 微信登录认证 (auth.go)
- **WechatApi** - 微信登录API结构体
- **WxLogin** - 微信小程序登录接口
- 路径: `POST /api/wxLogin`
- 功能: 通过微信code获取用户信息并生成JWT token

### 2. 微信轮播图 (banner.go)
- **WechatBannerApi** - 微信轮播图API结构体
- **WxGetBanners** - 获取轮播图列表接口
- 路径: `GET /api/wxBanners`
- 功能: 获取启用状态的轮播图，支持按类型筛选

### 3. 微信教师 (teacher.go)
- **WechatTeacherApi** - 微信教师API结构体
- **WxGetTeachers** - 获取教师列表接口
- 路径: `GET /api/wxTeachers`
- 功能: 获取教师列表，支持按排序方式筛选
- **WxGetTeacherDetail** - 获取教师详情接口
- 路径: `GET /api/wxTeachers/{id}`
- 功能: 获取教师详细信息及其所有课程列表

### 4. 模块入口 (enter.go)
- **ApiGroup** - 微信模块API分组
- 统一管理服务依赖和模块导出

## 特点

- ✅ **模块化设计** - 独立的微信功能模块，与系统管理模块平级
- ✅ **无需鉴权** - 所有接口都是公开接口
- ✅ **完整文档** - 包含完整的Swagger注释
- ✅ **类型安全** - 完整的请求/响应类型定义
- ✅ **错误处理** - 统一的错误处理机制
- ✅ **服务复用** - 复用系统已有的BannerService等服务

## 路由注册

在 `initialize/router_biz.go` 中通过以下方式注册：

```go
// 微信模块路由（独立模块）
wechatRouter := router.RouterGroupApp.Wechat
wechatRouter.InitWechatRouter(privateGroup, publicGroup)        // 微信登录
wechatRouter.InitWechatBannerRouter(privateGroup, publicGroup)  // 微信轮播图
wechatRouter.InitWechatTeacherRouter(privateGroup, publicGroup) // 微信教师
```

## API 引用

在主API入口 `api/v1/enter.go` 中引用：

```go
type ApiGroup struct {
    SystemApiGroup  system.ApiGroup
    ExampleApiGroup example.ApiGroup
    WechatApiGroup  wechat.ApiGroup  // 微信模块（包含WechatApi、WechatBannerApi、WechatTeacherApi）
}
```

## 扩展说明

未来可以在此目录下继续添加其他微信相关功能：
- 微信支付相关接口
- 微信用户管理接口
- 微信消息推送接口
- 微信分享相关接口
- 微信课程管理接口
- 微信活动管理接口
- 微信意见反馈接口

每个功能都可以创建独立的文件，保持模块的清晰和可维护性。

## 重构说明

本次重构将微信模块从 `api/v1/system/wechat` 和 `router/system/wechat` 移动到了与 system 同级的独立目录：
- `api/v1/wechat/`
- `router/wechat/`

这样的设计更清晰地区分了系统管理功能和微信小程序功能，便于后续扩展和维护。