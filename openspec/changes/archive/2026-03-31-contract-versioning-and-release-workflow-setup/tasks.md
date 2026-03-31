## 1. Release Policy Documentation

- [x] 1.1 Add a contract release policy document in `platform-contracts` that defines `contracts-vX.Y.Z` tags and the SemVer rules for patch, minor, and major contract releases.
- [x] 1.2 Update the repo entrypoint docs so maintainers can discover the release/tag policy from `README.md`.

## 2. Package Publish And Consumer Contract

- [x] 2.1 Document how `@mpa-forge/platform-contracts-client` is versioned and published to GitHub Packages, including the requirement that the package version matches the release tag version.
- [x] 2.2 Document the Bun/npm consumer bootstrap and install pattern for released package versions without committing registry credentials.
- [x] 2.3 Document the expected released-version consumption pattern for Go consumers of `platform-contracts`.

## 3. Release Checklist And Validation

- [x] 3.1 Add a maintainable pre-release checklist covering validation, generation drift, documentation updates, version alignment, and tag creation steps.
- [x] 3.2 Validate the documented commands and release checklist against the current repo entrypoints and update any stale references.

## 4. OpenSpec And Repo Sync

- [x] 4.1 Sync the implemented release workflow behavior into the canonical OpenSpec spec for `contract-release-workflow`.
- [x] 4.2 Archive this OpenSpec change after the implementation and validation work is complete.
