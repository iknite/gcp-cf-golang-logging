# Copyright (c) 2021-present cqisense. All Rights Reserved.
# See LICENSE for license information.

# Makefile configuration
.DEFAULT_GOAL := help
SHELL := /bin/bash

## test: call the CF
.PHONY: test
test:
	@bash examples/cf.sh

## cf-deploy: publish this project
cf-deploy:
	gcloud --quiet --project=${PROJECT_ID} functions deploy \
		gcp-cf-golang-logging \
		--region=${REGION} \
		--entry-point=logging-test \
		--trigger-http \
		--runtime=go118 \
		--timeout=60 \
		--service-account=${SERVICE_ACCOUNT} \
		--set-env-vars=PROJECT_ID=${PROJECT_ID} \
		--set-env-vars=REGION=${REGION}

## lint: check file compliances
.PHONY: lint
lint: deployments/secrets/baseline
	@golangci-lint run
	@pre-commit autoupdate
	@pre-commit run --all-files

## help: This help output
.PHONY: help
help: Makefile
	@printf "\nChoose a command run in $(shell basename ${PWD}):\n"
	@sed -n 's/^##//p' $< | column -t -s ":" |  sed -e 's/^/ /'
	@echo
