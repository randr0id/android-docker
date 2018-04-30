VERSION_SDK_TOOLS="3859397"

curl -s "https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip" > ~/sdk.zip && \
    unzip ~/sdk.zip -d ${ANDROID_HOME} && rm -v ~/sdk.zip

mkdir -p ~/.android && touch ~/.android/repositories.cfg

while read -r package; do PACKAGES="${PACKAGES}${package} "; done < packages.txt && \
    "${ANDROID_HOME}/tools/bin/sdkmanager" ${PACKAGES}

"${ANDROID_HOME}/tools/bin/sdkmanager" --update
