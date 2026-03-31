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
- Go with module-aware `go install` support for local Go plugin installation
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
- `make generate-check`

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
  - `protoc-gen-connect-es`
- Baseline policy avoids paid BSR dependencies:
  - no paid remote dependencies
  - no paid remote plugin features
  - local and CI use Buf CLI directly

## Code Generation

Generated outputs are committed to git:

- Go: `gen/go/`
- TypeScript client sources: `packages/typescript-client/src/gen/`

Generation commands:

- install code generation plugins: `make install-codegen-tools`
- regenerate artifacts: `make buf-generate`
- verify regeneration is clean: `make generate-check`
- compile generated Go artifacts: `make go-generated-check`
- build TypeScript client package: `make ts-client-build`

The repository installs Go plugins into a local `.bin/` directory and uses
workspace-local Node plugin binaries from `node_modules/.bin`, so generation does
not depend on globally installed plugin versions.

## Current Contract Scope

The first real contract baseline is a generic authenticated user flow:

- package: `blueprint.user.v1`
- service: `UserService`
- unary RPCs:
  - `EnsureCurrentUserProfile`
  - `GetCurrentUser`

This keeps the initial Phase 2 contract reusable across applications built from
the blueprint while still exercising a protected frontend-to-API path and an
explicit local-profile bootstrap step.

## CI Baseline

The repository includes a focused GitHub Actions workflow for Buf checks:

- `buf lint`
- `buf breaking` against `origin/main` once the baseline exists on `main`
- generation drift check after installing the pinned local plugins

This keeps the contract-policy baseline enforceable before the broader Phase 4 CI rollout.

## TypeScript Client Package Baseline

The generated TypeScript client package baseline lives in:

- `packages/typescript-client`

It is prepared for future GitHub Packages publishing with:

- scoped package name
- package exports
- build script
- publish registry metadata

Publishing itself is still handled later in the release workflow tasks.

Usage documentation:

- `docs/typescript-client-usage.md`
- `docs/go-server-usage.md`
- `docs/consumer-auth-usage.md`

## Contract Release Workflow

Released contract consumption is documented in:

- `docs/contract-release-workflow.md`
- `docs/contract-release-checklist.md`

These documents define:

- `contracts-vX.Y.Z` release tags
- semantic version rules for patch, minor, and major releases
- TypeScript package version alignment with release tags
- GitHub Packages consumer bootstrap and install expectations
- the pre-release validation and documentation checklist maintainers follow

## Test

Contract validation commands:

- `make contracts-check`
- `make contracts-check-ci`

Breaking-change checks compare the current branch against `main`.
Before the first contract release tag (`contracts-vX.Y.Z`), the helper skips strict
breaking enforcement so the initial contract surface can still be shaped. After the
first release tag exists, local and CI checks compare against the target branch
normally. CI compares against `origin/main` after fetching repository history.
