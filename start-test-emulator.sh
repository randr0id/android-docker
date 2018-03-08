#!/usr/bin/env bash

echo "no" | ${ANDROID_HOME}/tools/bin/avdmanager create avd -f -n android_test -b google_apis/x86 -k "system-images;android-26;google_apis;x86"
echo "no" | ${ANDROID_HOME}/tools/emulator @android_test -wipe-data -no-audio -no-window -verbose &
/utils/wait-for-emulator.sh

