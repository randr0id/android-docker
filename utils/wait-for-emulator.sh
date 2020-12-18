#!/usr/bin/env bash

set +e

bootanim=""
counter=0
timeout=360

until [[ "${bootanim}" =~ "stopped" ]]; do
    bootanim=`adb -e shell getprop init.svc.bootanim 2>&1 &`
    if [[ "${bootanim}" =~ "device not found" || "${bootanim}" =~ "device offline" || "${bootanim}" =~ "running" ]]; then
        let "counter += 1"
        echo "Waiting for emulator to start..."

        if [[ ${counter} -gt timeout ]]; then
            echo "Timeout (${timeout} seconds) reached; failed to start emulator"
            exit 1
        fi
    fi
    sleep 2
done

echo "Emulator is ready!"

