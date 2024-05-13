#!/bin/bash

LIBCOAP_PATH="${1}"
build_dir="$(pwd)/build"

sudo apt-get update && sudo apt-get install libcurl4-openssl-dev

mkdir -p $build_dir
cd $build_dir
if [ -n "$LIBCOAP_PATH" ]; then
    echo "Using libcoap from $LIBCOAP_PATH"
    cmake -DLIBCOAP_PATH="$LIBCOAP_PATH" ..
else
    cmake ..
fi

make