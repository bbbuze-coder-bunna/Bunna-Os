#!/bin/bash
set -e

APP_NAME="keycloak"
IMAGE_NAME="keycloak:latest"
CONTAINER_NAME="keycloak"
PORT=8010

echo ">> Starting deployment..."

echo ">> Building application..."
./mvnw clean package -DskipTests

if docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
  echo ">> Stopping existing container..."
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
fi

echo ">> Building Docker image..."
docker build -t ${IMAGE_NAME} .

echo ">> Running container..."
docker run -d \
  --name ${CONTAINER_NAME} \
  --network bb-net \
  --restart unless-stopped \
  -e SPRING_PROFILES_ACTIVE=uat \
  -e KC_CONSOLE_URL=http://10.1.13.41:8060 \
  -e KC_CLIENT_SECRET=rN9N8e4l8R7ThNXWOwF5BsFr61QIe1os \
  ${IMAGE_NAME}

echo ">> Deployment completed successfully"
echo ">> Application running on port ${PORT}"
