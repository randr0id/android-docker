#!/usr/bin/env bash

source /etc/os-release
CLOUD_SDK_REPO="cloud-sdk-${VERSION_CODENAME}"
echo "deb http://packages.cloud.google.com/apt ${CLOUD_SDK_REPO} main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | apt-key add -
apt-get -qqy update && apt-get install -qqy --no-install-recommends google-cloud-sdk

