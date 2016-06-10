#!/bin/sh

cleanup() {
    trap INT QUIT
    if [ -n "$harvesterpid" ]; then
        kill -INT  "$harvesterpid"
    fi
    if [ -n "$serverpid" ]; then
        kill -INT  "$serverpid"
    fi
    trap - INT QUIT
}

trap cleanup INT QUIT

log.io-server &
serverpid=$!
log.io-harvester &
harvesterpid=$!

wait "$serverpid" "$harvesterpid"
