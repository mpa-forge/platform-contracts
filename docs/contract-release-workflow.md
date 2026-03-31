# Contract Release Workflow

## Purpose

This document defines how `platform-contracts` is released once generated
artifacts are ready to be consumed outside the local sibling-workspace setup.
It is the source of truth for:

- contract release tags
- semantic versioning rules
- TypeScript package publish alignment
- consumer version pinning expectations
- the minimum release checklist

Use this document together with:

- `docs/contract-release-checklist.md`
- `docs/typescript-client-usage.md`
- `docs/go-server-usage.md`

## Release Boundary

Contract releases are cut from `platform-contracts` with git tags in the form:

- `contracts-vX.Y.Z`

These tags are the canonical release boundary for the contract repository.
They are the version source of truth for:

- released protobuf contract state
- generated Go artifact consumption expectations
- published `@mpa-forge/platform-contracts-client` package versions

`platform-contracts` does not use plain `vX.Y.Z` tags as the primary contract
release boundary.

## Semantic Versioning Rules

Contract releases use semantic versioning.

### Patch

Use the next patch version when the release includes:

- documentation-only corrections
- generation or packaging fixes that do not change the contract surface
- internal build or release workflow fixes with no consumer-facing contract
  change

Example:

- `contracts-v0.1.1` -> `contracts-v0.1.2`

### Minor

Use the next minor version when the release includes backward-compatible
contract additions, such as:

- new optional fields
- new backward-compatible RPCs
- additive generated package exports that do not break existing consumers

Example:

- `contracts-v0.1.1` -> `contracts-v0.2.0`

### Major

Use the next major version when the release includes a breaking contract change,
including:

- removing or renaming fields or procedures in place
- changing message or RPC behavior incompatibly
- any contract change that should force consumers to adopt a new versioned
  protobuf namespace or package boundary

Major releases must stay aligned with the repository's Buf breaking-change and
protobuf versioning rules. Do not make breaking changes in place and pretend
they are minor or patch releases.

## TypeScript Package Version Alignment

The TypeScript package:

- `@mpa-forge/platform-contracts-client`

must use the same `X.Y.Z` version as the corresponding release tag.

Examples:

- tag `contracts-v0.1.1` -> package version `0.1.1`
- tag `contracts-v0.2.0` -> package version `0.2.0`

Before creating a release tag:

1. bump `packages/typescript-client/package.json` to the intended release version
2. confirm the package builds successfully
3. confirm the release tag will use the matching `contracts-vX.Y.Z` version

This keeps the mapping between git release history and npm consumer installs
simple and explicit.

## TypeScript Package Publishing

The canonical TypeScript distribution channel is GitHub Packages.

Package details:

- package: `@mpa-forge/platform-contracts-client`
- registry: `https://npm.pkg.github.com`

Publishing happens after the release version has been prepared in the repo and
validated. The package should never be published with a version that does not
match the release tag version.

## Consumer Version Pinning

### TypeScript Consumers

Frontend and other Node/Bun consumers should:

- install a released package version from GitHub Packages
- pin an explicit released version
- avoid floating mainline artifacts as the default consumption path

Local sibling-workspace development can still use workspace-local wiring, but
published or reusable consumer setups should target released package versions.

### Go Consumers

Go consumers should:

- upgrade deliberately against released `platform-contracts` versions
- avoid treating `main` as the default dependency source for reusable baseline
  integrations
- keep the imported module/package paths stable while changing only the consumed
  released version

In practice, that means contract upgrades should be an explicit maintenance step,
not an implicit side effect of following unreviewed mainline changes.

## Release Process

At a high level, a contract release follows this order:

1. prepare the intended release version
2. run the contract validation and generation checks
3. confirm docs and package metadata are aligned
4. publish the TypeScript package version that matches the release
5. create the matching `contracts-vX.Y.Z` tag
6. document or announce the release for consumer repos that need to upgrade

Use `docs/contract-release-checklist.md` as the maintainers' step-by-step
release gate.

## Related Consumer Guidance

For frontend and package consumers:

- `docs/typescript-client-usage.md`

For Go consumers:

- `docs/go-server-usage.md`

For protected API auth expectations after installation:

- `docs/consumer-auth-usage.md`
