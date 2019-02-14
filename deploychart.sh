#!/bin/bash
SOURCE_CHARTS_REPO=$1
TARGET_CHARTS_REPO=$2
CHART_NAME=$3
USE_ENVIRONMENT=$4
docker run --rm -v $(pwd):/workspace -e DOCKER_REGISTRY=$DOCKER_REGISTRY -e DOCKER_TAG=$USE_ENVIRONMENT-$CI_COMMIT_SHA -e CI_PROJECT_NAME=$CI_PROJECT_NAME diginex/ca sh -c "helm repo add source-repo $SOURCE_CHARTS_REPO && cd charts/$CHART_NAME && gomplate -f config.values.yaml.gotmpl > default.values.yaml && helm dependency build && cd .. && helm package ./$CHART_NAME"
docker run --rm -v $(pwd)/charts:/mnt docker.bintray.io/jfrog/jfrog-cli-go:latest jfrog rt upload /mnt/*.tgz / --url=$TARGET_CHARTS_REPO --user=$ARTIFACTORY_USERNAME --password=$ARTIFACTORY_PASSWORD
