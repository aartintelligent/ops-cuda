REGISTRY = docker.io
ORGANIZATION = aartintelligent
CUDA_TARGET = cuda
CUDA_VERSIONS ?= 12.6
IMAGE = $(REGISTRY)/$(ORGANIZATION)/$(CUDA_TARGET)

# Helper to replace '.' with '-' in CUDA versions
VERSION_FORMATTED = $(shell echo $(version) | tr '.' '-')

build:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Building $(IMAGE):$(version)..."; \
		docker build --build-arg CUDA_VERSION=$(VERSION_FORMATTED) \
		--tag $(IMAGE):$(version) .; \
	)

push:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Pushing $(IMAGE):$(version)..."; \
		docker push $(IMAGE):$(version); \
	)

clean:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Removing image $(IMAGE):$(version)..."; \
		docker rmi -f $(IMAGE):$(version) || true; \
	)

.PHONY: build push clean
