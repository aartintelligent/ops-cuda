REGISTRY = docker.io
ORGANIZATION = aartintelligent
CUDA_TARGET = cuda
CUDA_VERSIONS ?= 12.6
IMAGE = $(REGISTRY)/$(ORGANIZATION)/$(CUDA_TARGET)

# Helper to replace '.' with '-' in CUDA versions
VERSION_FORMATTED = $(shell echo $(version) | tr '.' '-')

build:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Building $(IMAGE):$(version)-bookworm..."; \
		docker build --build-arg CUDA_VERSION=$(VERSION_FORMATTED) \
		--tag $(IMAGE):$(version)-bookworm .; \
	)

push:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Pushing $(IMAGE):$(version)-bookworm..."; \
		docker push $(IMAGE):$(version)-bookworm; \
	)

clean:
	@$(foreach version,$(CUDA_VERSIONS),\
		echo "Removing image $(IMAGE):$(version)-bookworm..."; \
		docker rmi -f $(IMAGE):$(version)-bookworm || true; \
	)

.PHONY: build push clean
