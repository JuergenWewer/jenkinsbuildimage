IMAGE_NAME = jw-jenkinsbuilder

.PHONY: build rebuild deploy lint

lint:
	@shellcheck deployer library
	@shellcheck validation-service/validation library
	@hadolint --ignore DL3007 --ignore DL3008 ./Dockerfile 

build:
	docker build -t $(IMAGE_NAME) .

test-image:
	docker run --rm -it --entrypoint=/bin/bash ergo-gitops-deployer

rebuild:
	docker build --no-cache -t $(IMAGE_NAME) .

deploy:
	docker tag $(IMAGE_NAME):latest jw-cloud.org:18443/$(IMAGE_NAME):latest
	docker push jw-cloud.org:18443/$(IMAGE_NAME):latest

