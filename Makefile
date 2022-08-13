# SET DOCKER_REGISTRY to change the docker registry
DOCKER_REGISTRY_PREFIX := $(if $(DOCKER_REGISTRY),$(DOCKER_REGISTRY)/,ghcr.io/)
IMAGE_TAG := $(if $(IMAGE_TAG),$(IMAGE_TAG),"latest")

# Enable GO111MODULE=on explicitly, disable it with GO111MODULE=off when necessary.
export GO111MODULE := on
GOENV  := GO15VENDOREXPERIMENT="1" CGO_ENABLED=0
CGOENV  := GO15VENDOREXPERIMENT="1" CGO_ENABLED=1
GO     := $(GOENV) go

default: build image image-push

build:
	$(GO) build -o bin/echo-all *.go

image:
	docker build -t ${DOCKER_REGISTRY_PREFIX}cwen0/echo-all:${IMAGE_TAG} .

image-push:
	docker push  "${DOCKER_REGISTRY_PREFIX}cwen0/echo-all:${IMAGE_TAG}"


.PYTHON: build
