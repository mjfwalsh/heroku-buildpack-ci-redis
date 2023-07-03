#!/usr/bin/env bash

set -euo pipefail

if [ $# -eq 1 ]
then
    STACK="$1"
else
    STACK="${STACK:-22}"
fi

REDIS_VERSION="${REDIS_VERSION:-7}"
BASE_IMAGE="heroku/heroku:${STACK}-build"
OUTPUT_IMAGE="redis-test-${STACK}"

echo "Building buildpack on stack ${STACK}...with redis version ${REDIS_VERSION}"

docker build \
    --build-arg "BASE_IMAGE=${BASE_IMAGE}" \
    ${REDIS_VERSION:+--build-arg "REDIS_VERSION=${REDIS_VERSION}"} \
    -t "${OUTPUT_IMAGE}" \
    .

echo "Checking redis-server presence and version..."
TEST_COMMAND="source .profile.d/redis.sh && (redis-server &>/dev/null &) && sleep 1 && redis-cli info | grep redis_version:${REDIS_VERSION}"
docker run --rm -t "${OUTPUT_IMAGE}" bash -c "${TEST_COMMAND}"

echo "Success!"
