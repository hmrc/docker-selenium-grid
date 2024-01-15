#!/bin/bash

ARCHITECTURE=$(uname -m)

if [ $ARCHITECTURE = "arm" ] || [ $ARCHITECTURE = "arm64" ] || [ $ARCHITECTURE = "aarch64" ]; then
  docker compose -f docker-compose.arm.yaml down
else
  docker compose up down
fi
