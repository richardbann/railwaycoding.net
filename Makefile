# This makefile is used on the production/test server

SHELL=/bin/bash

img := richardbann/railwaycoding

################################################################################
# self documenting makefile
################################################################################
.DEFAULT_GOAL := help
.PHONY: help
## print available targets
help: bold = $(shell tput bold; tput setaf 3)
help: reset = $(shell tput sgr0)
help:
	@echo
	@sed -nr \
		-e '/^## /{s/^## /    /;h;:a;n;/^## /{s/^## /    /;H;ba};' \
		-e '/^[[:alnum:]_\-]+:/ {s/(.+):.*$$/$(bold)\1$(reset):/;G;p};' \
		-e 's/^[[:alnum:]_\-]+://;x}' ${MAKEFILE_LIST}
	@echo

################################################################################
.PHONY: docker-down

## stop and remove all containers
docker-down:
	-docker stop railwaycoding_nginx
	-docker rm railwaycoding_nginx

################################################################################
.PHONY: up

## start the nginx container
up:
	docker run -d \
		-v "$(CURDIR)/site:/site" \
		-v "$(CURDIR)/.env-files:/.env-files" \
		-p 80:80 -p 443:443 \
		--name railwaycoding_nginx \
		$(img) nginx -g "daemon off;"

################################################################################
.PHONY: pull-image

## pull the latest docker image from the registry
pull-image:
	docker pull $(img)


################################################################################
.PHONY: upgrade

## pull the latest image, restart containers
upgrade: pull-image, docker-down, up
