#!/bin/bash
set -e

echo "[PROCESS]Start docker installation"

CONTAINER_PORT=5156
CONTAINER_NAME="mockpass-server"
OLD_CONTAINER_ID=$(docker ps -qa --filter name=$CONTAINER_NAME)
OLD_IMAGE_ID=$(docker images --filter=reference=$CONTAINER_NAME --format "{{.ID}}")

echo "[PROCESS]Build new docker image..."
docker build -t $CONTAINER_NAME .

if [ ! -z "$OLD_CONTAINER_ID" ]
then
	echo "[PROCESS]Stop old container.."
	docker stop $OLD_CONTAINER_ID
	
	echo "[PROCESS]Remove old container..."
	docker rm $OLD_CONTAINER_ID

	echo "[PROCESS]Remove old image..."
    docker rmi $OLD_IMAGE_ID
fi

echo "[PROCESS]Start docker container with name $CONTAINER_NAME port $CONTAINER_PORT ..."
docker run -d --restart unless-stopped -p $CONTAINER_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $CONTAINER_NAME
echo "[PROCESS]Done..."

echo "[PROCESS]Current docker container running ..."
docker ps
echo "[PROCESS]Deploy finish! happy coding."