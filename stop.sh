#!/bin/bash

if test -f .env; then
  source .env
fi

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"

$DOCKER_COMPOSE down --remove-orphans
