ifeq ($(TARGET), rhel)
    DOCKERFILE := Dockerfile.data-model.rhel

    ifndef DOCKER_REGISTRY
        $(error DOCKER_REGISTRY is not set)
    endif

    REGISTRY := $(DOCKER_REGISTRY)
else
    DOCKERFILE := Dockerfile.data-model
    REGISTRY?=registry.devshift.net
endif
REPOSITORY?=bayesian/data-model-importer
DEFAULT_TAG=latest

.PHONY: all docker-build fast-docker-build test get-image-name get-image-repository

all: fast-docker-build

docker-build:
	docker build --no-cache -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f $(DOCKERFILE) .

fast-docker-build:
	docker build -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f $(DOCKERFILE) .

test:
	./runtests.sh

get-image-name:
	@echo $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG)

get-image-repository:
	@echo $(REPOSITORY)

