#!/bin/bash

GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_SHORT_COMMIT=$(git rev-parse --short HEAD)
APP_VERSION=$(node -e "console.log(require('./package.json').version);")

#create release tag or testing tag based off the current branch
DOCKER_TAG=""
if [ $GIT_BRANCH = "master" ]; then
    DOCKER_TAG="v${APP_VERSION}"
else
    DOCKER_TAG="${GIT_BRANCH}_${APP_VERSION}"
    #TODO: add ability to detect CI build context (Travis, Drone, etc) and pull specific build number vars
    if [ -n "$CIRCLE_BUILD_NUM" ]; then
        DOCKER_TAG="${DOCKER_TAG}_${CIRCLE_BUILD_NUM}_${GIT_SHORT_COMMIT}"
    else
        DOCKER_TAG="${DOCKER_TAG}_${GIT_SHORT_COMMIT}"
    fi
fi

echo $DOCKER_TAG