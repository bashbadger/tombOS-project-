IMAGE ?= tombos_builder
DOCKERFILE ?= Dockerfile

.PHONY: docker-build docker-run build clean

docker-build:
	@echo "Building Docker image $(IMAGE)..."
	docker build -t $(IMAGE) -f $(DOCKERFILE) .

docker-run:
	@echo "Running Docker container $(IMAGE)..."
	# Pass through flash device if set
	if [ -n "$(FLASH_DEVICE)" ]; then \
	    docker run --rm -v $(PWD):/tombos --device $(FLASH_DEVICE) $(IMAGE) ./build_tombos.sh; \
	else \
	    docker run --rm -v $(PWD):/tombos $(IMAGE) ./build_tombos.sh; \
	fi

build: docker-build docker-run
	@echo "Build complete."

clean:
	@echo "Cleaning Docker image $(IMAGE)..."
	docker rmi $(IMAGE) || true
