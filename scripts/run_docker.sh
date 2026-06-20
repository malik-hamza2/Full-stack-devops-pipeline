#!/usr/bin/env bash

CONTAINER_NAME=spring-boot-shopping-cart
IMAGE_NAME=${CONTAINER_NAME}:dev
PORT=8070

echo "Building jar..."
mvn clean package

echo "Stopping old container if exists..."
docker stop $(docker ps -aq --filter name=${CONTAINER_NAME}) 2>/dev/null || true
docker rm $(docker ps -aq --filter name=${CONTAINER_NAME}) 2>/dev/null || true

echo "Building Docker image..."
docker build -t ${IMAGE_NAME} -f docker/Dockerfile .

echo "Running Docker container..."
docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
