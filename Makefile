include .env

DOCKER_IMAGE = leffen/pod-backup-tools
DOCKER_TAG = v0.1.1

build:
	docker build  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

push: build
	docker push  $(DOCKER_IMAGE):$(DOCKER_TAG)