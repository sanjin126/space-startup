-- 初始化脚本
-- 此脚本在 PostgreSQL 容器首次启动时执行

-- 确保使用 UTF-8 编码
SET client_encoding = 'UTF8';

-- 创建必要的扩展（如需要）
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 可以在这里添加初始数据
-- INSERT INTO ... ;


-- 创建 star 数据库和用户
CREATE USER star WITH PASSWORD 'star_password';
CREATE DATABASE star OWNER star;
GRANT ALL PRIVILEGES ON DATABASE star TO star;

-- 连接到 star 数据库并授予 schema 权限
\c star
GRANT ALL ON SCHEMA public TO star;

-- 输出初始化完成信息
DO $$
BEGIN
    RAISE NOTICE 'Database initialization completed successfully!';
END $$;

