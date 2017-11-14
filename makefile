SHELL=/bin/bash

usr := $(shell id -u):$(shell id -g)


.PHONY: run
run:
	docker-compose run --rm pelican bash

.PHONY: build-dev
build-dev:
	rm -rf site/output/*
	docker-compose run --rm -u $(usr) -w "/site" pelican pelican

.PHONY: build-prod
build-prod:
	rm -rf site/deploy/*
	docker-compose run --rm -u $(usr) -w "/site" pelican pelican -s publishconf.py -o deploy

.PHONY: deploy
deploy:
	ssh railwaycoding.net "cd /opt/railwaycoding.net && git pull"

.PHONY: gencerts
COMMON_NAME := railwaycoding.dev
SUBJECT_ALT_NAMES := "DNS:$(COMMON_NAME),DNS:localhost,IP:127.0.0.1"
gencerts:
	rm -rf .env-files/*.{crt,key,csr}

	# generate certificate authority private key
	@openssl genrsa -out ".env-files/$(COMMON_NAME)-ca.key" 2048

	# self signed CA certificate
	@openssl req -x509 -new -nodes -subj "/commonName=$(COMMON_NAME)-ca" \
	        -key ".env-files/$(COMMON_NAME)-ca.key" -sha256 -days 1024 \
					-out ".env-files/$(COMMON_NAME)-ca.crt"

	# generate private key for the server
	@openssl genrsa -out ".env-files/$(COMMON_NAME).key" 2048

	# certificate request
	@openssl req -new -sha256 -subj "/commonName=$COMMON_NAME" \
	        -key ".env-files/$(COMMON_NAME).key" -reqexts SAN \
					-out ".env-files/$(COMMON_NAME).csr" \
	        -config <(cat /etc/ssl/openssl.cnf \
	                  <(printf "[SAN]\nsubjectAltName=%s" "$(SUBJECT_ALT_NAMES)"))

	# sign the certificate with CA
	@openssl x509 -req -in ".env-files/$(COMMON_NAME).csr" \
	        -CA ".env-files/$(COMMON_NAME)-ca.crt" \
					-CAkey ".env-files/$(COMMON_NAME)-ca.key" \
	        -out ".env-files/$(COMMON_NAME).crt" -days 500 -sha256 \
					-extensions SAN -CAcreateserial \
					-CAserial ".env-files/$(COMMON_NAME)-ca.srl" \
	        -extfile <(cat /etc/ssl/openssl.cnf \
	                   <(printf "[SAN]\nsubjectAltName=%s" "$(SUBJECT_ALT_NAMES)"))

.PHONY: up
up:
	docker-compose up -d nginx

.PHONY: down
down:
	docker-compose down
