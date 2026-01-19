#!/bin/bash

APP_NAME=devops-demo
IMAGE_NAME=nakulsurve/devops-demo:latest

docker pull $IMAGE_NAME

docker stop $APP_NAME || true
docker rm $APP_NAME || true

docker run -d \
  --name $APP_NAME \
  -p 80:3000 \
  --restart always \
  $IMAGE_NAME
