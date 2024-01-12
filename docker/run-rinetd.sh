#!/bin/bash

IFS=',' read -r -a PORTS <<< $PORTS

for PORT in "${PORTS[@]}"; do
  echo "Mapping localhost:$PORT to $TARGET_IP:$PORT"
  echo "localhost $PORT $TARGET_IP $PORT" >> ~/rinetd.conf
done

rinetd --conf-file ~/rinetd.conf

/opt/bin/entry_point.sh
