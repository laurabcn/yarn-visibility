.PHONY: help setup start stop bash test unit-tests coverage lint format typecheck arch-check qa migrate

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

# Docker
setup: ## Build containers and install dependencies
	docker compose build
	docker compose run --rm api uv pip install --system -e ".[dev]"

start: ## Start all containers
	docker compose up -d

stop: ## Stop all containers
	docker compose down

bash: ## Open shell in API container
	docker compose exec api bash

# Database
migrate: ## Run database migrations
	docker compose exec api alembic upgrade head

migrate-create m="": ## Create a new migration (make migrate-create m="add_mentions_table")
	docker compose exec api alembic revision --autogenerate -m "$(m)"

# Testing — equivalent to Pest
test: ## Run all tests
	docker compose exec api pytest

unit-tests: ## Run unit tests only
	docker compose exec api pytest tests/unit

integration-tests: ## Run integration tests only
	docker compose exec api pytest tests/integration

coverage: ## Run tests with coverage report (90% min)
	docker compose exec api pytest --cov=src --cov-report=html --cov-fail-under=90

# Quality — equivalent to make qa in kitt-api
lint: ## Lint code with ruff (equivalent to phpcs)
	docker compose exec api ruff check src tests

format: ## Auto-fix code style (equivalent to php-cs-fixer)
	docker compose exec api ruff format src tests
	docker compose exec api ruff check --fix src tests

typecheck: ## Static type checking (equivalent to phpstan + psalm)
	docker compose exec api mypy src

arch-check: ## Architecture dependency rules (equivalent to deptrac)
	docker compose exec api lint-imports

qa: lint typecheck arch-check test ## Full QA suite