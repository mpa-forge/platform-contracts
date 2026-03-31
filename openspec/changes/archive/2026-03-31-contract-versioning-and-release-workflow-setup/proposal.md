## Why

`platform-contracts` already generates publishable client artifacts, but the blueprint still lacks a clear release contract for when those artifacts become official, how the TypeScript package is versioned and published, and how consuming repos should pin and upgrade safely. We need that policy now so Phase 2 can move from workspace-only integration to a repeatable tagged release model that future blueprint forks can follow.

## What Changes

- Define the contract release policy for `platform-contracts`, including the meaning and use of `contracts-vX.Y.Z` tags and how SemVer applies to protobuf/package changes.
- Define the GitHub Packages npm publishing contract for `@mpa-forge/platform-contracts-client`, including package scope/name, registry/auth expectations, and publish-time version alignment with contract release tags.
- Define consumer installation and pinning conventions for Bun/npm-based frontend repos and the expected version-consumption pattern for Go consumers.
- Document the release checklist and the minimum validation gates required before a contract release is cut.

## Capabilities

### New Capabilities

- `contract-release-workflow`: release, publish, and consumer-versioning conventions for `platform-contracts` artifacts.

### Modified Capabilities

- None.

## Impact

- Affects `platform-contracts` release documentation, package publish workflow expectations, and consumer install guidance.
- Affects `frontend-web` and other future frontend repos through the GitHub Packages install/pinning contract.
- Affects Go consumer repos such as `backend-api` through documented tag/version consumption expectations.
- Establishes the Phase 2 source of truth needed before teams can publish and consume tagged contract releases safely.
