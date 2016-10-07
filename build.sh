#!/bin/bash
#builds a docker image for a node.js application

#tag defaults to latest if no input is provided
DOCKER_TAG=""
if [ -n "$1" ]; then
    DOCKER_TAG=$1
else
    DOCKER_TAG="latest"
fi

DOCKER_IMAGE_OWNER=shawnleankit
DOCKER_IMAGE_REPO=ci-harness

DOCKER_IMAGE="${DOCKER_IMAGE_OWNER}/${DOCKER_IMAGE_REPO}"

echo building image "[$DOCKER_IMAGE:$DOCKER_TAG]"
docker build -t --rm=false $DOCKER_IMAGE .