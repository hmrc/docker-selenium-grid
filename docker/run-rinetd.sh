#!/bin/bash

IFS=',' read -r -a TARGET_PORTS <<< $TARGET_PORTS

for TARGET_PORT in "${TARGET_PORTS[@]}"; do
  echo "Mapping localhost:$TARGET_PORT to $TARGET_IP:$TARGET_PORT"
  echo "localhost $TARGET_PORT $TARGET_IP $TARGET_PORT" >> ~/rinetd.conf
done

rinetd --conf-file ~/rinetd.conf

/opt/bin/entry_point.sh
