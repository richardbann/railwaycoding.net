SHELL=/bin/bash

usr := $(shell id -u):$(shell id -g)
ts := $(shell date -u +%Y-%m-%d-%H-%M-%S-%Z)
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
.PHONY: docker-build

## Build the docker image and tag it with the build timestamp
docker-build:
	docker build -t $(img):latest .
	docker tag $(img):latest $(img):$(ts)

################################################################################
.PHONY: docker-push

## Push to docker registry
docker-push: docker-build
	docker push $(img):latest
	docker push $(img):$(ts)

################################################################################
.PHONY: one-off

## launch a one-off terminal (as root), configured the same way as the
## production container
one-off:
	@docker run -it --rm \
		-v "$(CURDIR)/.env-files:/.env-files" \
		-v "$(CURDIR)/nginx.conf:/etc/nginx/nginx.conf" \
		-v "$(CURDIR)/site:/site" \
		$(img) bash

################################################################################
.PHONY: one-off-me

## launch a one-off terminal (as the current user)
one-off-me:
	@docker run -it --rm -u $(usr) \
		-v "$(CURDIR):/railwaycoding.net" \
		-w "/railwaycoding.net" \
		$(img) bash

################################################################################

define pelican =
	mkdir -p site/$(outdir)
	rm -rf site/$(outdir)/*
	docker run -t --rm \
		-v "$(CURDIR)/site:/site" \
		-u "$(usr)" \
		-w "/site" \
		$(img) pelican
endef

################################################################################
.PHONY: dev-build

## build the output directory for testing
dev-build: outdir = output
dev-build:
	$(pelican)

################################################################################
.PHONY: prod-build

## build the deploy directory with production settings (publishconf.py)
prod-build: outdir = deploy
prod-build:
	$(pelican) -o $(outdir) -s publishconf.py

################################################################################
.PHONY: gencerts

common_name := railwaycoding.dev
cert_name := railwaycoding.net
subject_alt_names := DNS:$(common_name),DNS:localhost,IP:127.0.0.1

san_row := printf "[SAN]\nsubjectAltName=%s" "$(subject_alt_names)"
openssl_conf := cat /etc/ssl/openssl.cnf <($(san_row))

## generate self signed certificates for local development
gencerts:
	rm -rf .env-files/*.{crt,key,csr}

	# generate certificate authority private key
	@openssl genrsa -out ".env-files/$(cert_name)-ca.key" 2048

	# self signed CA certificate
	@openssl req -x509 -new -nodes -subj "/commonName=$(common_name)-ca" \
	        -key ".env-files/$(cert_name)-ca.key" -sha256 -days 1024 \
					-out ".env-files/$(cert_name)-ca.crt"

	# generate private key for the server
	@openssl genrsa -out ".env-files/$(cert_name).key" 2048

	# certificate request
	@openssl req -new -sha256 -subj "/commonName=$(common_name)" \
	        -key ".env-files/$(cert_name).key" -reqexts SAN \
					-out ".env-files/$(cert_name).csr" \
	        -config <($(openssl_conf))

	# sign the certificate with CA
	@openssl x509 -req -in ".env-files/$(cert_name).csr" \
	        -CA ".env-files/$(cert_name)-ca.crt" \
					-CAkey ".env-files/$(cert_name)-ca.key" \
	        -out ".env-files/$(cert_name).crt" -days 500 -sha256 \
					-extensions SAN -CAcreateserial \
					-CAserial ".env-files/$(cert_name)-ca.srl" \
	        -extfile <($(openssl_conf))

################################################################################
.PHONY: docker-down

## stop and remove all containers
docker-down:
	-docker stop railwaycoding_dev-server_nginx
	-docker stop railwaycoding_dev-server_pelican
	-docker rm railwaycoding_dev-server_nginx
	-docker rm railwaycoding_dev-server_pelican

################################################################################
.PHONY: dev-serve

## start a web server and pelican in "regenerate" mode
dev-serve: docker-down
	docker run -d \
		-v "$(CURDIR)/site:/site" \
		-w /site \
		--stop-signal SIGINT \
		--name railwaycoding_dev-server_pelican \
		$(img) pelican -r

	docker run -d \
		-v "$(CURDIR)/.env-files:/.env-files" \
		-v "$(CURDIR)/nginx.conf:/etc/nginx/nginx.conf" \
		-v "$(CURDIR)/site/output:/site" \
		-p 80:80 -p 443:443 \
		--name railwaycoding_dev-server_nginx \
		$(img) nginx -g "daemon off;"

################################################################################
.PHONY: deploy-content

## build and deploy the production content
##     copies Makefile (to ./makefile) and site/deploy to ./site
deploy-content: prod-build
	scp Makefile railwaycoding.net:/opt/railwaycoding.net/makefile
	rsync -r -E --del -c \
		site/deploy/ railwaycoding.net:/opt/railwaycoding.net/site/
