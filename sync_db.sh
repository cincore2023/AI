#!/bin/bash

# 数据库同步脚本
# 功能：将 Docker 容器中的数据库同步到本地 SQL 文件

set -e  # 遇到错误立即退出

# 配置变量
DB_USER="gva"
DB_NAME="gva1"
DB_CONTAINER="gin-vue-admin-db"
SQL_DIR="./sql"
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Docker 容器是否运行
check_container() {
    if ! docker ps | grep -q $DB_CONTAINER; then
        log_error "数据库容器 $DB_CONTAINER 未运行，请先启动服务："
        echo "docker-compose up -d"
        exit 1
    fi
}

# 创建目录
create_directories() {
    log_info "创建目录..."
    mkdir -p $SQL_DIR
    mkdir -p $BACKUP_DIR
}

# 导出数据库结构
export_schema() {
    log_info "导出数据库结构到 $SQL_DIR/schema.sql..."
    docker-compose exec db pg_dump -U $DB_USER -d $DB_NAME --schema-only > $SQL_DIR/schema.sql
    
    if [ $? -eq 0 ]; then
        log_info "数据库结构导出成功！"
    else
        log_error "数据库结构导出失败！"
        exit 1
    fi
}

# 导出完整数据库
export_full_database() {
    log_info "导出完整数据库到 $SQL_DIR/full_database.sql..."
    docker-compose exec db pg_dump -U $DB_USER -d $DB_NAME > $SQL_DIR/full_database.sql
    
    if [ $? -eq 0 ]; then
        log_info "完整数据库导出成功！"
    else
        log_error "完整数据库导出失败！"
        exit 1
    fi
}

# 创建备份
create_backup() {
    log_info "创建数据库备份到 $BACKUP_DIR..."
    docker-compose exec db pg_dump -U $DB_USER -d $DB_NAME > $BACKUP_DIR/gva1_backup_$DATE.sql
    
    if [ $? -eq 0 ]; then
        log_info "备份创建成功：$BACKUP_DIR/gva1_backup_$DATE.sql"
    else
        log_error "备份创建失败！"
        exit 1
    fi
}

# 显示文件信息
show_file_info() {
    log_info "同步完成！文件信息："
    echo ""
    echo "📁 SQL 文件："
    if [ -f "$SQL_DIR/schema.sql" ]; then
        echo "  - $SQL_DIR/schema.sql ($(wc -l < $SQL_DIR/schema.sql) 行)"
    fi
    if [ -f "$SQL_DIR/full_database.sql" ]; then
        echo "  - $SQL_DIR/full_database.sql ($(wc -l < $SQL_DIR/full_database.sql) 行)"
    fi
    echo ""
    echo "📁 备份文件："
    if [ -f "$BACKUP_DIR/gva1_backup_$DATE.sql" ]; then
        echo "  - $BACKUP_DIR/gva1_backup_$DATE.sql ($(wc -l < $BACKUP_DIR/gva1_backup_$DATE.sql) 行)"
    fi
    echo ""
}

# 清理旧备份（保留最近 10 个）
cleanup_old_backups() {
    log_info "清理旧备份文件（保留最近 10 个）..."
    cd $BACKUP_DIR
    ls -t gva1_backup_*.sql 2>/dev/null | tail -n +11 | xargs -r rm
    cd - > /dev/null
}

# 主函数
main() {
    log_info "开始同步数据库到本地..."
    echo ""
    
    # 检查容器状态
    check_container
    
    # 创建目录
    create_directories
    
    # 导出数据库结构
    export_schema
    
    # 导出完整数据库
    export_full_database
    
    # 创建备份
    create_backup
    
    # 清理旧备份
    cleanup_old_backups
    
    # 显示结果
    show_file_info
    
    log_info "数据库同步完成！"
}

# 显示帮助信息
show_help() {
    echo "数据库同步脚本"
    echo ""
    echo "用法："
    echo "  $0          # 同步数据库到本地"
    echo "  $0 --help   # 显示帮助信息"
    echo ""
    echo "功能："
    echo "  - 导出数据库结构到 sql/schema.sql"
    echo "  - 导出完整数据库到 sql/full_database.sql"
    echo "  - 创建备份到 backups/ 目录"
    echo "  - 自动清理旧备份（保留最近 10 个）"
    echo ""
    echo "要求："
    echo "  - Docker 和 docker-compose 已安装"
    echo "  - 数据库容器正在运行"
    echo ""
}

# 脚本入口
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    show_help
else
    main
fi 