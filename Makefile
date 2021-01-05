SHELL := /bin/bash
BASEDIR = $(shell pwd)

APP_NAME=es-index-cleaner
APP_VERSION=1.0.0
IMAGE_NAME="makeoptim/${APP_NAME}:${APP_VERSION}"
IMAGE_LATEST="makeoptim/${APP_NAME}:latest"

build:
	echo ${IMAGE_NAME}; \
	docker build -t ${IMAGE_NAME} -f Dockerfile .;
push: build
	docker tag ${IMAGE_NAME} ${IMAGE_LATEST};
	docker push ${IMAGE_NAME};
	docker push ${IMAGE_LATEST};
help:
	@echo "build - build docker image"
	@echo "push - push docker image to docker"