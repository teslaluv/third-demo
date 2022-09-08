TAG ?= latest
REGISTRY_ID ?= 716735117304
REPOSITORY_REGION ?= us-east-1
APP_NAME ?= app
ENV_NAME ?= env
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/${APP_NAME}-${ENV_NAME}

.PHONY: build
build:
	$(MAKE) docker-login
	sudo docker build -t $(REPO_NAME):$(TAG) -f ./Dockerfile .
	sudo docker push $(REPO_NAME):$(TAG)

.PHONY: docker-login
docker-login:
	aws ecr get-login-password --region $(REPOSITORY_REGION) | sudo docker login --username AWS --password-stdin $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com
