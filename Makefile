export PROJECT_IP = 127.0.0.1
export PROJECT_DOMAIN = micro-service.dev.internal
export PROJECT_NAME = micro-service
export SHELL = bash

DOCKER = docker
DOCKER_COMPOSE = docker-compose
CLI = $(DOCKER_COMPOSE) exec -T ${PROJECT_NAME}
PROJECT_ID = ls

start: ##@development start project
	$(DOCKER_COMPOSE) up -d --remove-orphans
.PHONY: start

stop: ##@development stop project
	$(DOCKER_COMPOSE) stop
.PHONY: stop

down: ##@development delete project container
	$(DOCKER_COMPOSE) down
.PHONY: down

ps: ##@development show running container
	$(DOCKER_COMPOSE) ps
.PHONY: ps

logs: ##@development show server logs
	$(DOCKER_COMPOSE) logs -f
.PHONY: logs

cli: ##@development get shell
	$(DOCKER_COMPOSE) exec ${PROJECT_NAME} $(SHELL)
.PHONY: cli

build: ##@development build
	$(DOCKER_COMPOSE) build
.PHONY: build

setup: ##@development configure development environment
	grep -q -F "${PROJECT_IP} ${PROJECT_DOMAIN}" /etc/hosts || sudo sh -c "echo '${PROJECT_IP} ${PROJECT_DOMAIN}' >> /etc/hosts"
	$(DOCKER_COMPOSE) restart ${PROJECT_NAME}
.PHONY: setup

integration: start ##@integration tests
	$(DOCKER) run -v ${PWD}/dev/tests:/etc/newman -t postman/newman_alpine33 --collection='$(PROJECT_ID).postman_collection.json' --environment='$(PROJECT_ID).postman_environment.json' -s
.PHONY: integration
