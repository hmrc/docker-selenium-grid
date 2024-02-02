#!/bin/bash

if test -f .env; then
  source .env
fi

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"

DOCKER_COMPOSE_FILE=docker-compose.arm.yaml

ARCHITECTURE=$(uname -m)
if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  DOCKER_COMPOSE_FILE=docker-compose.arm.yaml
fi

TARGET_PORTS=$(sm2 --ports | awk '{ print $1 }' | uniq | grep -vxF "0" | grep -vxF "6099" | grep -vxF "7900" | paste -sd "," -),11000,27017,$EXTRA_PORTS

# add or replace target ports in .env that should be accessible by browser on localhost
# we have to add them to the .env file so they are available if using lima nerdctl which
# doesn't copy environment variables from the current process into the vm running docker
# WARNING: lima nerdctl doesn't support alternatively named env files via composes env_file
touch .env \
  && awk '!/^TARGET_PORTS=/' .env > temp \
  && mv temp .env \
  && echo "TARGET_PORTS=$TARGET_PORTS" >> .env

$DOCKER_COMPOSE --file="$DOCKER_COMPOSE_FILE" up --detach --build
