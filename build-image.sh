#!/bin/bash
#****************************************************************#
# Create Date: 2019-02-02 22:16
#********************************* ******************************#

ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NAME="hugo"
TAG="9.23-$(date +%Y''%m''%d''%H''%M''%S)"
NS="knative-sample"

echo "build"
${ROOTDIR}/hugo --baseUrl="/"

docker build -t "${NAME}:${TAG}" .

array=( registry.cn-hangzhou.aliyuncs.com)
for registry in "${array[@]}"
do
    echo "push images to ${registry}/${NS}/${NAME}:${TAG}"
    docker tag "${NAME}:${TAG}" "${registry}/${NS}/${NAME}:${TAG}"
    docker push "${registry}/${NS}/${NAME}:${TAG}"

    docker tag "${NAME}:${TAG}" "${registry}/${NS}/${NAME}:latest"
    docker push "${registry}/${NS}/${NAME}:latest"
done
