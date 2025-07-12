# PostgreSQL + Redis 数据库 Docker 部署指南

## 1. 启动数据库和 Redis 容器

在项目根目录下执行：

```bash
docker-compose up -d
```

这会启动 PostgreSQL 15 和 Redis 7 容器，配置如下：

### PostgreSQL 配置：
- 容器名：gin-vue-admin-db
- 端口：5432（映射到本地 5432）
- 用户名：gva
- 密码：gva1234
- 数据库名：gva
- 数据持久化：pgdata volume

### Redis 配置：
- 容器名：gin-vue-admin-redis
- 端口：6379（映射到本地 6379）
- 数据持久化：redisdata volume
- 启用 AOF 持久化

## 2. 查看容器状态

```bash
docker ps
```

应看到 `gin-vue-admin-db` 和 `gin-vue-admin-redis` 状态均为 `Up`。

## 3. 查看服务日志

```bash
# 查看数据库日志
docker-compose logs -f db

# 查看 Redis 日志
docker-compose logs -f redis
```

## 4. 连接数据库

### 方式一：进入容器连接
```bash
docker-compose exec db psql -U gva -d gva
```

### 方式二：本地连接
```bash
psql -h localhost -p 5432 -U gva -d gva
```

## 5. 连接 Redis

### 方式一：进入容器连接
```bash
docker-compose exec redis redis-cli
```

### 方式二：本地连接
```bash
redis-cli -h localhost -p 6379
```

## 6. 常用命令

- 停止所有服务：
  ```bash
  docker-compose down
  ```
- 重启数据库：
  ```bash
  docker-compose restart db
  ```
- 重启 Redis：
  ```bash
  docker-compose restart redis
  ```
- 删除所有数据（数据会丢失）：
  ```bash
  docker-compose down -v
  ```

## 7. 数据持久化

- PostgreSQL 数据存储在 `pgdata` volume 中
- Redis 数据存储在 `redisdata` volume 中
- 容器重启、删除后重建，数据不会丢失
- 只有执行 `docker-compose down -v` 才会删除数据

## 8. 连接参数

### PostgreSQL：
- Host: localhost 或 127.0.0.1
- Port: 5432
- User: gva
- Password: gva1234
- Database: gva

### Redis：
- Host: localhost 或 127.0.0.1
- Port: 6379
- 无密码（默认配置）

## 9. 注意事项

- 确保本地 5432 和 6379 端口未被占用
- 如需修改数据库或 Redis 配置，请编辑 docker-compose.yml 中的 environment 部分
- 生产环境建议为 Redis 设置密码
- Redis 已启用 AOF 持久化，数据更安全