#!/bin/bash

CMD="docker service create --name ui --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer"

echo $CMD

vagrant ssh nodeAZ1N1 -c "$CMD"

