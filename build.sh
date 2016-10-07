#!/bin/bash
#builds a docker image for a node.js application
#adds a build number to the image tag if the script is being ran via Circle CI
#replace DOCKER_IMAGE_OWNER and DOCKER_IMAGE_REPO with appropriate values

DOCKER_IMAGE_OWNER=owner
DOCKER_IMAGE_REPO=repo
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_SHORT_COMMIT=$(git rev-parse --short HEAD)
APP_VERSION=$(node -e "console.log(require('./package.json').version);")

DOCKER_IMAGE="${DOCKER_IMAGE_OWNER}/${DOCKER_IMAGE_REPO}"

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

echo building image "[$DOCKER_IMAGE:$DOCKER_TAG]"
docker build -t $DOCKER_IMAGE .