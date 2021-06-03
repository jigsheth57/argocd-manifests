#!/bin/sh
set -o errexit

export APP_NAME="${1:fe-time-tracking}"
export APP_IMAGE_REVISION="${2:-v1.0}"
export APP_GIT_URL="${3:-https://github.com/jigsheth57/fe-time-tracking}"
export APP_IMAGE_TAG="${4:-kind-registry:5000/fetimetracking}"

# ytt -f build.yaml --data-value-yaml APP_NAME=$APP_NAME --data-value-yaml APP_IMAGE_REVISION=$APP_IMAGE_REVISION --data-value-yaml APP_GIT_URL=$APP_GIT_URL --data-value-yaml APP_IMAGE_TAG=$APP_IMAGE_TAG -o yaml > app-build/build.yaml
#
# git add .
# git commit -m "update $APP_NAME $APP_IMAGE_REVISION"
# git push

ytt -f deploy.yaml --data-value-yaml APP_NAME=$APP_NAME --data-value-yaml APP_IMAGE_DIGEST="$(kubectl get images.kpack.io $APP_NAME -o json | jq -r '.status.latestImage')" -o yaml > app-deploy/deploy.yaml

git add .
git commit -m "update $APP_NAME $APP_IMAGE_REVISION"
git push
