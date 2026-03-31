# Agent Context

## Local Entry Point

This file is the repo-local entry point for agent context.

## Always Load

Before making changes:

1. Read `README.md`.
2. Read `Makefile` if present.
3. Run `make sync-agent-skills` before starting major changes or when shared skill guidance may have changed.
4. Read `../platform-blueprint-specs/common/AGENTS.md`.
5. Read `.codex/skills/automated-ai-worker/SKILL.md` when the repo is being changed by an automated AI worker or when following the same autonomous workflow manually.
6. Read `../platform-blueprint-specs/implementation/phases/phase-2-contracts-service-skeletons-and-data-baseline.md`.
7. Read `../platform-blueprint-specs/implementation/phase-tasks/phase-2-contracts-service-skeletons-and-data-baseline-tasks.md`.
8. Check local repo docs under `docs/` if the task touches generation or package publishing details.

## Repo Role

- Own protobuf contracts as the single source of truth for backend and frontend clients.
- Generate Go and TypeScript artifacts.
- Publish the generated TypeScript client package to GitHub Packages.

## Relevant Shared Constraints

- Buf usage is CLI-only in local and CI for baseline; no paid BSR dependency.
- Generated TypeScript client is intended for GitHub Packages publishing.
- Generated artifacts are committed to git as part of normal development flow.

## Consult Conditionally

- `../platform-blueprint-specs/platform-specification.md` only when the task needs broader stack or release-policy context.

## Shared Managed Skills

Run `make sync-agent-skills` before major changes so the local common skill
copies stay current.

## Typical Validation

- repo-local generation command once introduced
- `make lint`
- `make format-check`

## Priority of Instructions

Repo-local instructions override shared planning docs.

If local repo docs conflict with a shared planning file, the more specific repo or task instruction wins.
