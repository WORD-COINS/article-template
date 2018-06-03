#!/bin/bash

set -ex

if [[ "$BITBUCKET_BRANCH" == "master" ]]; then
  export IMAGE_NAME=wordcoins/article-template
  docker tag "$IMAGE_NAME" "${IMAGE_NAME}:latest"
  docker push "${IMAGE_NAME}:latest"
fi
