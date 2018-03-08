# Android Docker Image for GitLab CI

_A Docker image for building and testing Android apps with GitLab CI._

This Docker image contains the Android SDK and common packages required for building and testing Android apps with GitLab CI.

## Example `.gitlab-ci.yml`
~~~
image: randr0id/gitlab-ci-android

cache:
  key: ${CI_PROJECT_ID}
  paths:
    - .gradle/

stages:
  - analysis
  - test
  - build

before_script:
  - export GRADLE_USER_HOME=$(pwd)/.gradle 
  - chmod +x ./gradlew

lint:
  stage: analysis
  script:
    - ./gradlew lintRelease
  artifacts:
    paths:
    - app/build/reports/

unit_test:
  stage: test
  script:
    - ./gradlew test
  artifacts:
    paths:
    - app/build/reports/tests/

android_test:
  stage: test
  script:
      - /utils/start-test-emulator.sh
      - ./gradlew connectedAndroidTest
  artifacts:
    paths:
      - app/build/reports/androidTests/

build_release:
  stage: build
  script:
    - ./gradlew clean
    - ./gradlew assembleRelease
  artifacts:
    paths:
    - app/build/outputs/apk/
    - app/build/outputs/mapping/
~~~


## License
    Copyright 2018 Randy Webster. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.