#!/bin/bash

export TARGET_PORTS=$(sm2 --status | grep PASS | awk -F '|' '{ print $5 }' | tr -d "[:blank:]" | paste -sd "," -),11000

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  docker compose -f docker-compose.arm.yaml up -d --build
else
  docker compose up -d --build
fi
