# Contract Release Checklist

Use this checklist before publishing a released `platform-contracts` version.

## 1. Prepare the release version

- choose the intended `contracts-vX.Y.Z` release version
- confirm the semantic version type is correct:
  - patch for non-breaking fixes
  - minor for backward-compatible additions
  - major for breaking contract changes
- update `packages/typescript-client/package.json` so the package version matches
  the intended release version

## 2. Validate the repository state

Run from the repository root:

- `make buf-lint`
- `make buf-breaking`
- `make generate-check`
- `make go-generated-check`
- `make ts-client-build`
- or `make contracts-check`

Confirm:

- protobuf lint passes
- breaking checks pass for the intended baseline
- generated artifacts are clean with no drift
- generated Go artifacts compile
- the TypeScript client package builds successfully

## 3. Confirm documentation and publish metadata

Confirm these are accurate for the release:

- `README.md`
- `docs/contract-release-workflow.md`
- `docs/typescript-client-usage.md`
- `docs/go-server-usage.md`
- `packages/typescript-client/package.json`
- `packages/typescript-client/README.md`

Specifically verify:

- the TypeScript package version matches the intended release version
- GitHub Packages remains the documented publish target
- consumer install guidance still points at released versions, not floating
  mainline artifacts

## 4. Publish the TypeScript package

Before publishing:

- ensure GitHub Packages auth is available in the publishing environment
- ensure the package version has not already been published

Publish the package only with the version that matches the intended release tag.

## 5. Create the contract release tag

After the release contents and package version are confirmed:

- create the matching git tag in the form `contracts-vX.Y.Z`
- push the tag to the repository

The tag version and the published package version must match exactly.

## 6. Post-release follow-through

After the release is published:

- record the released version in the relevant change or release notes
- communicate upgrade expectations to consumer repos when needed
- treat future consumer updates as deliberate version bumps, not floating
  follow-mainline behavior
