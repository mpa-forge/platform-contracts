# platform-contracts

Contracts repository for protobuf schemas and generated clients in the platform blueprint.

## Structure
- `proto/`: protobuf source definitions
- `gen/`: generated artifacts produced by contract tooling
- `packages/`: publishable client package outputs
- `docs/`: contract-specific documentation
- `scripts/`: local utility and developer scripts

## Setup
This repository is currently at the skeleton stage.
Buf CLI wiring, generation commands, and package publishing workflow will be added in later tasks.

## Run
This repository does not expose a runtime service.
Generation and validation commands will be added in later Phase 1 and Phase 2 tasks.

## Test
No automated validation commands are configured yet.
Contract linting and breaking-change checks will be introduced in later tasks.
