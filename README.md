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

- Shared workspace requirement: keep `platform-blueprint-specs` checked out as a sibling directory if you want to use `make doctor`.
- Required: GNU Make (or a compatible `make` implementation) and a bash-compatible shell
- Recommended: `mise` or `asdf` for automatic tool installation from `.tool-versions`
- Fallback: manually install the pinned tool versions listed above

Run the setup commands from the repository root:

- Workstation checks: `make doctor`
- Bootstrap: `make bootstrap`

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
Use contract validation and generation commands instead:

- `make buf-lint`
- `make buf-breaking`
- `make contracts-check`
- `make buf-generate`

## Buf Baseline

This repository uses Buf CLI as the contract policy and validation tool.

- `buf.yaml` defines:
  - module path: `proto/`
  - module name: `buf.build/mpa-forge/platform-contracts`
  - lint policy: `STANDARD`
  - breaking policy: `FILE`
- `buf.gen.yaml` defines the future local-plugin generation baseline for:
  - `protoc-gen-go`
  - `protoc-gen-connect-go`
  - `protoc-gen-es`
- Baseline policy avoids paid BSR dependencies:
  - no paid remote dependencies
  - no paid remote plugin features
  - local and CI use Buf CLI directly

## CI Baseline

The repository includes a focused GitHub Actions workflow for Buf checks:

- `buf lint`
- `buf breaking` against `origin/main` once the baseline exists on `main`

This keeps the contract-policy baseline enforceable before the broader Phase 4 CI rollout.

## Test

Contract validation commands:

- `make contracts-check`
- `make contracts-check-ci`

Breaking-change checks compare the current branch against `main`.
Before the first contract release tag (`contracts-vX.Y.Z`), the helper skips strict
breaking enforcement so the initial contract surface can still be shaped. After the
first release tag exists, local and CI checks compare against the target branch
normally. CI compares against `origin/main` after fetching repository history.
