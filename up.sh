#!/bin/bash
# Jenkins 部署脚本 - 精简版

set -e

PROJECT_DIR="/www/wwwroot/demo"
PORT="39009"

cd ${PROJECT_DIR}

# 停止旧进程
lsof -t -i:${PORT} | xargs -r kill -9

# 删除测试文件
rm -rf src/test

# Maven 打包
mvn clean package -DskipTests

# 后台运行
nohup java -jar target/demo-0.0.1-SNAPSHOT.jar --server.port=${PORT} > app.log 2>&1 &

echo "部署完成，PID: $!"