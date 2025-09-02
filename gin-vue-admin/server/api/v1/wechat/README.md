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
│       ├── image.go     # 微信图片上传相关API
│       └── enter.go     # 模块入口文件
└── router/
    ├── system/          # 系统管理路由
    ├── example/         # 示例路由
    └── wechat/          # 微信小程序路由（新）
        ├── auth.go      # 微信认证路由
        ├── banner.go    # 微信轮播图路由
        ├── image.go     # 微信图片上传路由
        └── enter.go     # 路由入口文件
```

## 功能模块

### 1. 微信登录认证 (auth.go)
- **WechatApi** - 微信登录API结构体
- **WxLogin** - 微信小程序登录接口
- 路径: `POST /api/wxLogin`
- 功能: 通过微信code获取用户信息并生成JWT token
- **WxBindSalesperson** - 绑定销售员接口
- 路径: `POST /api/wxBindSalesperson` (需要鉴权)
- 功能: 通过手机号查找并绑定销售员，设置关系渠道

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

### 4. 微信课程 (course.go)
- **WechatCourseApi** - 微信课程API结构体
- **WxGetCourses** - 获取课程列表接口
- 路径: `GET /api/wxCourses`
- 功能: 获取课程列表，支持分页和筛选
- **WxGetCourseDetail** - 获取课程详情接口
- 路径: `GET /api/wxCourses/{id}`
- 功能: 获取课程详细信息及其所有教师列表

### 5. 微信活动 (activity.go)
- **WechatActivityApi** - 微信活动API结构体
- **WxGetActivities** - 获取活动列表接口
- 路径: `GET /api/wxActivities`
- 功能: 获取在展示时间内的活动列表，支持分页、分类筛选和关键词搜索
- **WxGetActivityDetail** - 获取活动详情接口
- 路径: `GET /api/wxActivities/{id}`
- 功能: 获取在展示时间内的活动详细信息

### 6. 微信图片上传 (image.go)
- **WechatImageApi** - 微信图片上传API结构体
- **WxUploadImage** - 上传图片接口
- 路径: `POST /api/wx/uploadImage`
- 功能: 上传图片文件，支持分类ID参数

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
wechatRouter.InitWechatRouter(privateGroup, publicGroup)         // 微信登录
wechatRouter.InitWechatBannerRouter(privateGroup, publicGroup)   // 微信轮播图
wechatRouter.InitWechatTeacherRouter(privateGroup, publicGroup)  // 微信教师
wechatRouter.InitWechatCourseRouter(privateGroup, publicGroup)   // 微信课程
wechatRouter.InitWechatActivityRouter(privateGroup, publicGroup) // 微信活动
```

## API 引用

在主API入口 `api/v1/enter.go` 中引用：

```go
type ApiGroup struct {
    SystemApiGroup  system.ApiGroup
    ExampleApiGroup example.ApiGroup
    WechatApiGroup  wechat.ApiGroup  // 微信模块（包含WechatApi、WechatBannerApi、WechatTeacherApi、WechatCourseApi、WechatActivityApi、WechatImageApi）
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
- 微信图片上传接口

每个功能都可以创建独立的文件，保持模块的清晰和可维护性。

## 重构说明

本次重构将微信模块从 `api/v1/system/wechat` 和 `router/system/wechat` 移动到了与 system 同级的独立目录：
- `api/v1/wechat/`
- `router/wechat/`

这样的设计更清晰地区分了系统管理功能和微信小程序功能，便于后续扩展和维护。