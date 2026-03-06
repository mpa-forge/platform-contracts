# platform-contracts

Contracts repository for protobuf schemas and generated clients in the platform blueprint.

## Structure
- proto/: protobuf source definitions
- gen/: generated artifacts produced by contract tooling
- packages/: publishable client package outputs
- docs/: contract-specific documentation
- scripts/: local utility and developer scripts

## Toolchain
- GNU Make (or a compatible make implementation)
- Node.js 24.13.1
- npm 11.8.0
- Buf 1.65.0
- Version pin source: .tool-versions and package.json

## Setup
Before running bootstrap:
- Required: GNU Make (or a compatible make implementation)
- Recommended: mise or sdf for automatic tool installation from .tool-versions
- Fallback: manually install the pinned tool versions listed above

Run the bootstrap command from the repository root:
- Make: make bootstrap

Bootstrap validates the pinned toolchain and installs npm dependencies via 
pm ci.
If mise or sdf is available, the script will use it to install the pinned toolchain automatically.

## Run
This repository does not expose a runtime service.
Generation and validation commands will be added in later Phase 1 and Phase 2 tasks.

## Test
No automated validation commands are configured yet.
Contract linting and breaking-change checks will be introduced in later tasks.
