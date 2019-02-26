#!/bin/bash
CHART_NAME=$1
TARGET_ENVIRONMENT=$2
RELEASE_NAME=$3
NAME_SPACE=$4
docker run --rm -v $(pwd)/environments:/workspace -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -e KOPS_CLUSTER_NAME=$KOPS_CLUSTER_NAME -e KOPS_STATE_STORE=$KOPS_STATE_STORE -e RELEASE_NAME=$RELEASE_NAME -e SUPPRESS_INFO=true diginex/ca sh -c "helm repo add diginex $CHART_REPOSITORY --username $ARTIFACTORY_USERNAME --password $ARTIFACTORY_PASSWORD && helm fetch diginex/$CHART_NAME --untar && cd $CHART_NAME && gomplate -t _helpers.tpl -d config=\"merge:new|default\" -d default=default.values.yaml -d new=../$TARGET_ENVIRONMENT.config.values.yaml -f values.yaml.gotmpl > values.yaml && cat values.yaml && helm upgrade -i $RELEASE_NAME diginex/$CHART_NAME -f values.yaml --namespace $NAME_SPACE"