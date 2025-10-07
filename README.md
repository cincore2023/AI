# AI 项目

本项目包含以下子项目：
- gin-vue-admin: 后端管理系统
- wechat: 微信小程序前端

## 文档

所有项目文档都位于 [docs](docs/) 文件夹中：

- [项目综合说明](docs/项目综合说明.md) - 包含项目整体架构、技术栈、部署流程等完整信息
- [后端项目说明](docs/后端项目说明.md) - 后端详细功能说明
- [独立微信用户体系说明](docs/独立微信用户体系说明.md) - 微信用户体系详细说明

## 快速开始

1. 启动 Docker 环境:
   ```bash
   docker-compose up -d
   ```

2. 初始化数据库和运行后端服务:
   ```bash
   cd gin-vue-admin/server
   go run main.go
   ```

3. 运行前端管理界面:
   ```bash
   cd gin-vue-admin/web
   npm install
   npm run serve
   ```

4. 运行微信小程序:
   ```bash
   cd wechat
   pnpm install
   pnpm dev
   ```