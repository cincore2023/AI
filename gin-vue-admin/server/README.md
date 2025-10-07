# Gin-Vue-Admin 后端服务

## 项目介绍

Gin-vue-admin 后端服务是基于 [Gin](https://gin-gonic.com/) 开发的 RESTful API 服务，提供完整的后台管理功能。

## 技术栈

- **语言**: Go 1.22+
- **框架**: Gin
- **ORM**: GORM
- **数据库**: PostgreSQL
- **缓存**: Redis
- **API 文档**: Swagger
- **配置管理**: Viper
- **日志**: Zap
- **权限控制**: Casbin
- **JWT认证**: golang-jwt/jwt

## 目录结构

```shell
├── api
│   └── v1
├── config
├── core
│   └── internal
├── docs
├── global
├── initialize
├── middleware
├── model
│   ├── common
│   ├── example
│   └── system
├── packfile
├── resource
│   ├── excel
│   ├── page
│   └── template
├── router
│   ├── example
│   ├── system
│   └── wechat
├── service
│   ├── example
│   └── system
├── source
├── task
├── utils
│   ├── ast
│   ├── autocode
│   ├── breakpoint_continue.go
│   ├── captcha
│   ├── casbin_util.go
│   ├── claims.go
│   ├── directory.go
│   ├── fmt_plus.go
│   ├── hash.go
│   ├── human_duration.go
│   ├── human_duration_test.go
│   ├── json.go
│   ├── json_test.go
│   ├── jwt.go
│   ├── plugin
│   ├── request
│   ├── server.go
│   ├── system_events.go
│   ├── timer
│   ├── upload
│   ├── validator.go
│   ├── validator_test.go
│   ├── verify.go
│   ├── wechat_pay.go
│   └── zip.go
└── main.go
```

| 文件夹       | 说明                    | 描述                        |
| ------------ | ----------------------- | --------------------------- |
| `api`        | api层                   | api层 |
| `--v1`       | v1版本接口              | v1版本接口                  |
| `config`     | 配置包                  | config.yaml对应的配置结构体 |
| `core`       | 核心文件                | 核心组件(zap, viper, server)的初始化 |
| `--internal` | 初始化内部函数 | gorm 的 longger 自定义,在此文件夹的函数只能由 `initialize` 层进行调用 |
| `docs`       | swagger文档目录         | swagger文档目录 |
| `global`     | 全局对象                | 全局对象 |
| `initialize` | 初始化 | router,redis,gorm,validator, timer的初始化 |
| `middleware` | 中间件层 | 用于存放 `gin` 中间件代码 |
| `model`      | 模型层                  | 模型对应数据表              |
| `--common`   | 公共模型                | 公共模型定义                |
| `--example`  | 示例模型                | 示例模型                    |
| `--system`   | 系统模型                | 系统模型                    |
| `packfile`   | 静态文件打包            | 静态文件打包 |
| `resource`   | 静态资源文件夹          | 负责存放静态文件                |
| `--excel` | excel导入导出默认路径 | excel导入导出默认路径 |
| `--page` | 表单生成器 | 表单生成器 打包后的dist |
| `--template` | 模板 | 模板文件夹,存放的是代码生成器的模板 |
| `router`     | 路由层                  | 路由层 |
| `--example`  | 示例路由                | 示例路由                    |
| `--system`   | 系统路由                | 系统路由                    |
| `--wechat`   | 微信路由                | 微信路由                    |
| `service`    | service层               | 存放业务逻辑问题 |
| `--example`  | 示例服务                | 示例服务                    |
| `--system`   | 系统服务                | 系统服务                    |
| `source` | source层 | 存放初始化数据的函数 |
| `task` | 任务层 | 定时任务相关 |
| `utils`      | 工具包                  | 工具函数封装            |
| `--timer` | timer | 定时器接口封装 |
| `--upload`      | oss                  | oss接口封装        |

