SHELL=/bin/bash

usr := $(shell id -u):$(shell id -g)

.PHONY: run
run:
	USER=$(usr) docker-compose run --rm pelican bash

create:
	rm -rf site/output
	USER=$(usr) docker-compose run --rm pelican pelican
