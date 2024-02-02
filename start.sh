#!/bin/bash

#if test -f .env; then
#  source .env
#fi

TARGET_PORTS=$(sm2 --ports | awk '{ print $1 }' | uniq | grep -vxF "0" | paste -sd "," -),11000,27017,$EXTRA_PORTS

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"
DOCKER_COMPOSE_FILE=docker-compose.yaml

ARCHITECTURE=$(uname -m)
if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  DOCKER_COMPOSE_FILE=docker-compose.arm.yaml
fi

# because when docker is an alias for `lima nerdctl` it doesn't pass env variables to the vm
## docker is running within we have to bake our env variables via build arguments
#$DOCKER_COMPOSE --file="$DOCKER_COMPOSE_FILE" build \
#  --build-arg TARGET_PORTS=$TARGET_PORTS \
#  --build-arg TARGET_IP=$TARGET_IP

# originally when I tried it via env_file I used a file other than ".env" and it seems
# like lima nerdctl compose will only grab stuff from .env - not other env_files in the
# docker-compose.yaml config
touch .env # in case it doesn't exist
sed -i" " '/^TARGET_PORTS/d' .env # in case they've already been set
echo "TARGET_PORTS=$TARGET_PORTS" >> .env # so we use the latest
# TODO is there a better way to express the above? Seems to sometimes create multiple .env files

$DOCKER_COMPOSE --file="$DOCKER_COMPOSE_FILE" up --detach --build
