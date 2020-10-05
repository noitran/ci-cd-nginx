WORKDIR ?= ./dist
DOCKER_IMAGE ?= nginx:1.19.2-alpine
IMAGE_TAG ?= noitran/nginx:alpine-latest

build: clean build-fresh
.PHONY: build

build-fresh:
	set -x;
	mkdir $(WORKDIR);
	sed -e 's/%%DOCKER_IMAGE%%/$(DOCKER_IMAGE)/g' ./Dockerfile.template > $(WORKDIR)/Dockerfile
	docker build -f $(WORKDIR)/Dockerfile . -t $(IMAGE_TAG)
.PHONY: build

test:
	# Nginx needs to start after php-fpm (It depends on upstream) successfully starts,
	# we need to modify /etc/hosts by adding host before starting the Nginx container, or it will fail.
	# See: https://docs.docker.com/engine/reference/run/#managing-etchosts
	dgoss run --add-host app:127.0.0.1 -t $(IMAGE_TAG)
.PHONY: best

clean:
	if [ -d "$(WORKDIR)" ]; then \
		rm -Rf $(WORKDIR); \
	fi
.PHONY: clean

docker-push:
	docker push $(IMAGE_TAG)
.PHONY: docker-push





