.PHONY: dev build test lint migrate-up migrate-down docker-up docker-down swagger kafka-topics clean

ifneq (,$(wildcard ../.env))
    include ../.env
    export
endif
SPACE_PATH ?= ../space-demo

# 执行迁移（up）
migrate-up:
	migrate -path ../star/migrations -database "postgres://star:star_password@localhost:5432/star?sslmode=disable" up
	migrate -path ${SPACE_PATH}/migrations -database "postgres://space:space_dev@localhost:5432/space?sslmode=disable" up
# 创建 Kafka topics
kafka-topics:
	docker exec space-kafka kafka-topics --create --topic nft.tx.request --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1 || true
	docker exec space-kafka kafka-topics --create --topic nft.tx.success --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1 || true
	docker exec space-kafka kafka-topics --create --topic nft.tx.failed --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1 || true

pwd:
	ls ../star/migrations
up:
	docker compose up -d
build:
	docker compose build
