#!/bin/bash
#
ARG=$1
source Environment

function build() {
    docker build -t ${CONTAINER_NAME} \
         --add-host "${CONTAINER_NAME}:127.0.0.1" \
         .
}

# block running as root, to avoid screwing up permissions
if [ "$(id -u)" = "0" ]; then
    >&2 echo "\n\nCan't run as root. Please drop elevated permissions and try again...\n"
    exit 1
fi

build ${ARG}
