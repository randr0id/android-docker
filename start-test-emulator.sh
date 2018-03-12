#!/usr/bin/env bash

android=26
abi=x86

usage="$(basename "$0") [-h] [-a android] [-b abi] -- Create and start an Android emulator.

where:
    -h: Show this help text
    -a: Specify the emulator Android API (default: ${android})
    -b: Specify the emulator ABI (default: ${abi})"

while getopts ':hab:' option; do
  case "$option" in
    h) echo "$usage"
        exit
        ;;
    a) android=${OPTARG}
        ;;
    b) abi=${OPTARG}
        ;;
  esac
done
shift $((OPTIND - 1))

echo "Starting Android emulator with API ${android} and ABI ${abi}"
echo "no" | ${ANDROID_HOME}/tools/bin/avdmanager create avd -f -n android_test -b "google_apis/${abi}" -k "system-images;android-${android};google_apis;${abi}"
echo "no" | ${ANDROID_HOME}/tools/emulator @android_test -wipe-data -no-audio -no-window -verbose & ${BASH_SOURCE%/*}/wait-for-emulator.sh

