#!/bin/bash
set -x # print the commands we run to the logs

TARGET_IP="${TARGET_IP:-$(
  (dig +short host.lima.internal host.docker.internal \
    && cat /etc/hosts | grep host.linux.internal | awk '{print $1}') \
  | head -n 1
)}"

# for some reason rinetd doesn't seem to like mapping to IP addresses
# so we explicitly set (or override) host.docker.internal in /etc/hosts
# to the IP for the host that we either get passed or figure out above
echo "$TARGET_IP host.docker.internal" | sudo tee -a /etc/hosts

IFS=',' read -r -a TARGET_PORTS <<< $TARGET_PORTS

for TARGET_PORT in "${TARGET_PORTS[@]}"; do
  echo "Mapping localhost:$TARGET_PORT to $TARGET_IP:$TARGET_PORT"
  echo "localhost $TARGET_PORT host.docker.internal $TARGET_PORT" >> ~/rinetd.conf
done

# if there is a port conflict then rinetd will not be started
# this means that a change to service manager config could stop
# people from being able to use these browsers once they pull
# in a version of service manager config with the conflicting port.
# it currently won't stop the browsers from starting, so it might
# be hard to debug the issue.
#
# TODO how can we make a failure to start rinetd stop the container from running with a meaningful error message
# TODO how can we stop a failure to bind to one port where there's a conflict prevent other ports being mapped
rinetd --conf-file ~/rinetd.conf --foreground &
# running in the foreground and forking means we can see errors in logs

/opt/bin/entry_point.sh
