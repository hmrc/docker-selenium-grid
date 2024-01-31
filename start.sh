#!/bin/bash

source .env

TARGET_PORTS=$(sm2 --ports | awk '{ print $1 }' | uniq | grep -vxF "0" | paste -sd "," -),11000,27017,$EXTRA_PORTS

DOCKER_COMPOSE_FILE=docker-compose.yaml

ARCHITECTURE=$(uname -m)
if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  DOCKER_COMPOSE_FILE=docker-compose.arm.yaml
fi

# because when docker is an alias for `lima nerdctl` it doesn't pass env variables to the vm
# docker is running within we have to bake our env variables via build arguments
docker compose --file="$DOCKER_COMPOSE_FILE" build \
  --build-arg TARGET_PORTS=$TARGET_PORTS \
  --build-arg TARGET_IP=$TARGET_IP

docker compose --file="$DOCKER_COMPOSE_FILE" up -d
