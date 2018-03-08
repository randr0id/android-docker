#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Missing arguments!"
    echo "Usage: start-test-emulator.sh <android_sdk>"
    exit 1
fi

androidSdk=$1

echo "no" | ${ANDROID_HOME}/tools/bin/avdmanager create avd -f -n android_test -b google_apis/x86 -k "system-images;android-${androidSdk};google_apis;x86"
echo "no" | ${ANDROID_HOME}/tools/emulator @android_test -wipe-data -no-audio -no-window -verbose & ${BASH_SOURCE%/*}/wait-for-emulator.sh

