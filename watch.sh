#!/bin/bash

BROWSER=$1

if test -f .env; then
  source .env
fi

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"

$DOCKER_COMPOSE port $BROWSER 7900 | xargs -I {} open http://{}
