#!/usr/bin/env bash

android=26
abi='x86'
avd_name='android_ci_test'

usage="$(basename "$0") [-h] [-a android] [-b abi] [-n name] -- Create and start an Android emulator.

where:
    -h: Show this help text
    -a: Specify the emulator Android API (default: ${android})
    -b: Specify the emulator ABI (default: ${abi})
    -n: Specify the emulator name (default: ${avd_name})"

while getopts ':ha:b:n:' option; do
  case "${option}" in
    h) echo "${usage}"
        exit ;;
    a) android=${OPTARG} ;;
    b) abi=${OPTARG} ;;
    n) avd_name=${OPTARG} ;;
  esac
done

echo "Starting Android emulator ${avd_name} with API ${android} and ABI ${abi}"
${ANDROID_HOME}/tools/bin/sdkmanager "system-images;android-${android};google_apis;${abi}"
${ANDROID_HOME}/tools/bin/avdmanager delete avd -n ${avd_name}
echo "no" | ${ANDROID_HOME}/tools/bin/avdmanager create avd -f -n ${avd_name} -b "google_apis/${abi}" -k "system-images;android-${android};google_apis;${abi}"
echo "no" | ${ANDROID_HOME}/tools/emulator @${avd_name} -wipe-data -no-audio -no-window -verbose & ${BASH_SOURCE%/*}/wait-for-emulator.sh

