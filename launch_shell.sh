#!/bin/bash

PROJECT_NAME="my-project"

docker image inspect "$PROJECT_NAME-image"
if [ "$?" -ne 0 ]; then
    docker build -t "$PROJECT_NAME-image" .
fi

docker container inspect "$PROJECT_NAME-container"
if [ "$?" -eq 0 ]; then
    docker container stop "$PROJECT_NAME-container"
    docker container rm "$PROJECT_NAME-container"
fi

docker run --name "$PROJECT_NAME-container" \
    -v "$(pwd):/app" \
    -it --entrypoint /bin/bash \
    "$PROJECT_NAME-image"

exit 0
