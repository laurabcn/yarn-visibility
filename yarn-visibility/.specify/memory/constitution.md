<!-- Sync Impact Report
Version change: 0.0.0 (template) → 1.0.0 (initial ratification)
Added sections: Core Principles, Tech Stack, Quality Gates, Governance
Templates requiring updates: ✅ constitution written from template
-->

# Yarn Visibility Constitution

## Core Principles

### I. Domain-First
The domain layer MUST be free of framework and infrastructure dependencies.
All business logic (mention detection, scoring, brand monitoring) lives in `domain/`.
Application and Infrastructure layers depend on Domain — never the reverse.
This is enforced by import-linter architecture tests.

### II. AI Provider Agnosticism
All LLM calls MUST go through an abstract interface (`AIGeneratorClientInterface`).
No application or domain code may import a concrete AI client (Gemini, OpenAI, etc.) directly.
Swapping providers requires only an Infrastructure change.

### III. Defensive AI Response Parsing
Every LLM response MUST be validated before use — models hallucinate and change format without notice.
Parsers MUST handle: missing fields, unexpected JSON structure, markdown wrappers, citation markers.
Every parser MUST have a fallback that never raises an unhandled exception to the caller.

### IV. Test-First (NON-NEGOTIABLE)
Tests are written before implementation. Red → Green → Refactor.
Minimum 90% coverage enforced by pytest-cov on every CI run.
Unit tests for domain and application. Integration tests for DB and AI clients (with mocks).

### V. Explicit Over Implicit
Type hints are MANDATORY on all functions and methods (enforced by mypy strict mode).
No dynamic attribute access, no `Any` unless explicitly justified with a comment.
Pydantic models for all API request/response shapes.

## Tech Stack

- **Backend**: Python 3.12 + FastAPI
- **Task queue**: Celery + Redis (async LLM calls)
- **Database**: PostgreSQL 16 (SQLAlchemy async + Alembic migrations)
- **AI clients**: Google Gemini (primary), OpenAI GPT (secondary)
- **Frontend**: Generated via v0.dev (Next.js/React) — not owned by this repo
- **Containerisation**: Docker Compose (api, worker, db, redis)

## Quality Gates

All of the following MUST pass before merging to `main`:

- `make lint` — ruff (equivalent to phpcs + php-cs-fixer)
- `make typecheck` — mypy strict (equivalent to phpstan + psalm)
- `make arch-check` — import-linter (equivalent to deptrac)
- `make test` — pytest with 90% coverage minimum

Commit messages MUST follow Conventional Commits (`feat`, `fix`, `chore`, `test`, `docs`, `refactor`).

## Governance

This constitution supersedes all other practices and preferences.
Amendments require: description of the change, rationale, and update to this file.
All PRs must verify compliance with the quality gates above.
The `main` branch is always deployable.

**Version**: 1.0.0 | **Ratified**: 2026-07-02 | **Last Amended**: 2026-07-02