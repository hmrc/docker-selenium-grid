#!/bin/bash

BROWSER=$1

if test -f .env; then
  source .env
fi

DOCKER_COMPOSE="${DOCKER_COMPOSE:-docker compose}"

if [ -z "${BROWSER}" ]; then
  echo "Provide the browser you want to watch as an argument (chrome,chromium,firefox,edge)"
  echo "For example: ./watch.sh chrome"
  exit 1
fi

case "$(uname)" in
    Darwin*) OPEN="open";;
    *)       OPEN="xdg-open"
esac

$DOCKER_COMPOSE port $BROWSER 7900 | xargs -I {} $OPEN http://{}
