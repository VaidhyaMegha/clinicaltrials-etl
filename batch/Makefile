all: run

# This makefile contains some convenience commands for deploying and publishing.

# For example, to build and run the docker container locally, just run:
# $ make

# or to publish the :latest version to the specified registry as :1.0.0, run:
# $ make publish version=1.0.0

registry = gcr.io/clinicaltrialsdata
name ?= test-etl-container
version ?= latest
AWS_ACCESS_KEY_ID ?= xxxx
AWS_SECRET_ACCESS_KEY ?= xxxx

image:
	$(call blue, "Building docker image...")
	docker build -t ${name}:${version} .

run: publish
	$(call blue, "Running Docker image locally...")
	nohup docker run -d  -i -t --rm  -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} ${registry}/${name}:${version}

ecr-login:
	echo "login not needed"

publish: image ecr-login
	$(call blue, "Publishing Docker image to registry...")
	docker tag ${name}:latest ${registry}/${name}:${version}
	docker push ${registry}/${name}:${version}

define blue
	@tput setaf 6
	@echo $1
	@tput sgr0
endef
