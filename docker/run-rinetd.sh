#!/bin/bash

TARGET_IP="${TARGET_IP:-$(
  (dig +short host.lima.internal host.docker.internal \
    && cat /etc/hosts | grep host.linux.internal | awk '{print $1}') \
  | head -n 1
)}"

echo "$TARGET_IP host.docker.internal" | sudo tee -a /etc/hosts

IFS=',' read -r -a TARGET_PORTS <<< $TARGET_PORTS

for TARGET_PORT in "${TARGET_PORTS[@]}"; do
  echo "Mapping localhost:$TARGET_PORT to $TARGET_IP:$TARGET_PORT"
  echo "localhost $TARGET_PORT host.docker.internal $TARGET_PORT" >> ~/rinetd.conf
done

rinetd --conf-file ~/rinetd.conf

/opt/bin/entry_point.sh
