#!/bin/bash

export IMAGE_NAME=alpine-postgres-pandas-numpy

export IMAGE_VERSION=py3-11-poetry-lowspace
export FULLY_QUALIFIED_IMAGE_NAME=bruvio/$IMAGE_NAME


docker build -f Dockerfile-postgres-pandas-numpy.dockerfile --no-cache -t $IMAGE_NAME:$IMAGE_VERSION -t $IMAGE_NAME:$IMAGE_VERSION ./


docker tag $IMAGE_NAME:$IMAGE_VERSION $FULLY_QUALIFIED_IMAGE_NAME:$IMAGE_VERSION

docker login
docker push $FULLY_QUALIFIED_IMAGE_NAME:$IMAGE_VERSION

