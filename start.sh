#!/bin/bash

if test -f .env; then
  source .env
fi

TARGET_PORTS=$(sm2 --ports | awk '{ print $1 }' | uniq | grep -vxF "0" | grep -vxF "6099" | grep -vxF "7900" | paste -sd "," -),11000,27017,$EXTRA_PORTS

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"
DOCKER_COMPOSE_FILE=docker-compose.yaml

ARCHITECTURE=$(uname -m)
if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  DOCKER_COMPOSE_FILE=docker-compose.arm.yaml
fi

# because when docker is an alias for `lima nerdctl` it doesn't pass env variables to the vm
# docker is running within we have to bake our env variables via build arguments
$DOCKER_COMPOSE --file="$DOCKER_COMPOSE_FILE" build \
  --build-arg TARGET_PORTS=$TARGET_PORTS \
  --build-arg TARGET_IP=$TARGET_IP

$DOCKER_COMPOSE --file="$DOCKER_COMPOSE_FILE" up --detach
