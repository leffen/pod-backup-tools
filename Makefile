include .env

DOCKER_IMAGE = leffen/pod-backup-tools
DOCKER_TAG = v0.1.0

buildd:
	docker build  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .