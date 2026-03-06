# platform-contracts

Contracts repository for protobuf schemas and generated clients in the platform blueprint.

## Structure

- `proto/`: protobuf source definitions
- `gen/`: generated artifacts produced by contract tooling
- `packages/`: publishable client package outputs
- `docs/`: contract-specific documentation
- `scripts/`: local utility and developer scripts

## Toolchain

- GNU Make (or a compatible `make` implementation) and a bash-compatible shell
- Node.js `24.13.1`
- npm `11.8.0`
- Buf `1.65.0`
- Version pin source: `.tool-versions` and `package.json`

## Setup

Before running bootstrap:

- Required: GNU Make (or a compatible `make` implementation) and a bash-compatible shell
- Recommended: `mise` or `asdf` for automatic tool installation from `.tool-versions`
- Fallback: manually install the pinned tool versions listed above

Run the bootstrap command from the repository root:

- Make: `make bootstrap`

Bootstrap validates the pinned toolchain and installs npm dependencies via `npm ci`.
If `mise` or `asdf` is available, the script will use it to install the pinned toolchain automatically.

## Lint and Format

- Install git hooks: `make precommit-install`
- Run all pre-commit checks manually: `make precommit-run`
- Run repo lint checks: `make lint`
- Apply formatting: `make format`
- Check formatting only: `make format-check`

## Run

This repository does not expose a runtime service.
Generation and validation commands will be added in later Phase 1 and Phase 2 tasks.

## Test

No automated validation commands are configured yet.
Contract linting, formatting, and breaking-change checks will be introduced incrementally in later tasks.
