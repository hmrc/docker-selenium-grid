#!/bin/bash

export TARGET_PORTS=$(sm2 --ports | awk '{ print $1 }' | uniq | paste -sd "," -),11000,27017

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  docker compose -f docker-compose.arm.yaml up -d --build
else
  docker compose up -d --build
fi
