## ADDED Requirements

### Requirement: Contract releases use versioned `contracts-vX.Y.Z` tags

`platform-contracts` SHALL define contract releases through git tags named `contracts-vX.Y.Z`, and the documented release policy SHALL explain how additive, breaking, and patch-level contract changes map to semantic version increments.

#### Scenario: Maintainer prepares a backward-compatible additive release

- **WHEN** maintainers add a backward-compatible contract change and prepare a release
- **THEN** the documented release workflow instructs them to create the next minor `contracts-vX.Y.Z` tag

#### Scenario: Maintainer prepares a breaking contract release

- **WHEN** maintainers introduce a contract-breaking change that requires a new major version boundary
- **THEN** the documented release workflow instructs them to cut a new major `contracts-vX.Y.Z` tag and keep the breaking policy aligned with the protobuf compatibility rules

### Requirement: TypeScript package publishing aligns with contract release tags

`platform-contracts` MUST define `@mpa-forge/platform-contracts-client` as a GitHub Packages-distributed artifact whose published npm version matches the `X.Y.Z` version of the corresponding `contracts-vX.Y.Z` release tag.

#### Scenario: Maintainer publishes the TypeScript client for a contract release

- **WHEN** maintainers publish `@mpa-forge/platform-contracts-client` for a released contract version
- **THEN** the documented workflow requires the package version to match the associated `contracts-vX.Y.Z` tag version
- **AND** the publish destination is `https://npm.pkg.github.com`

### Requirement: Consumer install guidance uses released versions and documented auth bootstrap

Consumers of `platform-contracts` artifacts MUST be instructed to install released versions rather than floating mainline artifacts, and Bun/npm consumers MUST be given a documented GitHub Packages auth/bootstrap pattern that does not require committed credentials.

#### Scenario: Frontend repo consumes the TypeScript package from GitHub Packages

- **WHEN** a Bun- or npm-based frontend repo installs `@mpa-forge/platform-contracts-client`
- **THEN** the documented consumer guidance tells it how to authenticate to `npm.pkg.github.com`
- **AND** the guidance pins a released package version instead of a floating branch or unpublished workspace state

#### Scenario: Go repo consumes released contracts

- **WHEN** a Go service repo consumes generated code from `platform-contracts`
- **THEN** the documented release workflow tells maintainers to upgrade against released contract versions deliberately instead of tracking unreviewed mainline changes

### Requirement: Contract releases require a documented pre-release checklist

`platform-contracts` SHALL publish a release checklist that includes the minimum validation, generation, documentation, and version-alignment steps required before cutting a contract release.

#### Scenario: Maintainer prepares to tag a contract release

- **WHEN** maintainers are ready to publish a contract release
- **THEN** the documented checklist requires contract validation checks, clean generation output, version alignment, and the relevant consumer/publish documentation updates to be confirmed before the tag is created
