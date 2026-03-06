# platform-contracts

Contracts repository for protobuf schemas and generated clients in the platform blueprint.

## Structure
- `proto/`: protobuf source definitions
- `gen/`: generated artifacts produced by contract tooling
- `packages/`: publishable client package outputs
- `docs/`: contract-specific documentation
- `scripts/`: local utility and developer scripts

## Toolchain
- Node.js `24.13.1`
- npm `11.8.0`
- Buf `1.65.0`
- Version pin source: `.tool-versions` and `package.json`

## Setup
Run one of the following bootstrap commands from the repository root:
- PowerShell: `./scripts/bootstrap.ps1`
- POSIX shell: `./scripts/bootstrap.sh`

Bootstrap validates the pinned toolchain and installs npm dependencies via `npm ci`.
If `mise` or `asdf` is available, the script will use it to install the pinned toolchain automatically.

## Run
This repository does not expose a runtime service.
Generation and validation commands will be added in later Phase 1 and Phase 2 tasks.

## Test
No automated validation commands are configured yet.
Contract linting and breaking-change checks will be introduced in later tasks.
