include .env
export

.PHONY: help
help: ## display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: tool
tool: ## Install tool.
	@aqua i

.PHONY: up
up: ## docker compose up
	@docker compose --project-name astrotbls --file ./.docker/compose.yaml up -d

.PHONY: down
down: ## docker compose down
	@docker compose --project-name astrotbls down --volumes

.PHONY: balus
balus: ## destroy everything about docker. (containers, images, volumes, networks.)
	@docker compose --project-name astrotbls down --rmi all --volumes

.PHONY: migrate
migrate:
	@(cd schema && bun run prisma db push)

.PHONY: psql
psql:
	@docker exec -it postgres psql -U postgres

.PHONY: prisma
prisma:
	@(cd schema && bun run prisma studio)

.PHONY: prismafmt
prismafmt:
	@(cd schema && bun run prisma format)

.PHONY: doc
doc:
	@./script/doc.sh

.PHONY: astro
astro:
	@(cd doc && bun run start)
