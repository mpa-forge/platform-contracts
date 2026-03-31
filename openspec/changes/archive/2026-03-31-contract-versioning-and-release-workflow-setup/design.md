## Context

`platform-contracts` already generates Go and TypeScript artifacts and includes the baseline npm metadata needed for `@mpa-forge/platform-contracts-client`, but there is still no explicit release contract that ties repository tags, package versions, validation gates, and consumer install behavior together. The frontend currently proves that local and workspace consumption works, and the planning repo now expects a future state where the same frontend code can consume a published GitHub Packages release without changing imports or client wiring.

This design is documentation- and workflow-heavy rather than implementation-heavy, but it is still cross-cutting: it affects the contracts repo, frontend consumer guidance, and the expectations that backend and future consumer repos should follow. The main constraint is that the blueprint should stay pragmatic and low-ceremony: Phase 2 needs a release workflow teams can actually follow, not a complicated release automation system before there is a real need for it.

## Goals / Non-Goals

**Goals:**

- Define one contract release policy for `platform-contracts` that makes `contracts-vX.Y.Z` the contract promotion boundary.
- Define how the TypeScript package version aligns with the contract release tag.
- Define the GitHub Packages publish/install contract for Bun/npm consumers without requiring committed credentials.
- Define how consuming repos pin and upgrade released contract versions.
- Define the minimum checklist of validation and documentation work required before publishing a contract release.

**Non-Goals:**

- Implement a full release automation pipeline in this task.
- Change protobuf namespaces or contract compatibility policy beyond documenting how they affect versioning.
- Change frontend or backend runtime code.
- Introduce a second package registry or multi-registry publishing strategy.

## Decisions

### Use `contracts-vX.Y.Z` tags as the release boundary

- Contract releases are cut from `platform-contracts` using git tags in the form `contracts-vX.Y.Z`.
- Those tags are the canonical release boundary for both contract artifacts and the published TypeScript client package.

Why:

- The repo already treats contract releases differently from general repository versioning, and Phase 2 planning explicitly references `contracts-vX.Y.Z`.
- A contract-specific tag prefix keeps the meaning unambiguous and avoids confusion with generic repo release tags.

Alternative considered:

- Use plain `vX.Y.Z` tags for the repo.
- Rejected because `platform-contracts` is primarily a shared contract/distribution repo, and the blueprint already distinguishes contract versioning from generic application release versioning.

### Keep the TypeScript package version aligned to the release tag version

- `@mpa-forge/platform-contracts-client` uses the same `X.Y.Z` version as the `contracts-vX.Y.Z` tag being published.
- The package version is bumped before the release is cut and published with that exact version.

Why:

- Consumers need a simple mapping between the git release boundary and the npm package they install.
- Matching versions keeps frontend troubleshooting and upgrade planning much easier.

Alternative considered:

- Version the npm package independently from the contract tag.
- Rejected because it creates avoidable ambiguity during early blueprint adoption.

### Treat GitHub Packages as the canonical TypeScript distribution channel

- The TypeScript client is published to `npm.pkg.github.com` under the `@mpa-forge` scope.
- Consumer docs standardize the auth/bootstrap pattern rather than relying on checked-in credentials.

Why:

- The package metadata is already configured for GitHub Packages.
- This keeps the baseline aligned with the existing repo state and org ownership.

Alternative considered:

- Publish later to the public npm registry.
- Rejected for now because GitHub Packages is already the chosen baseline and sufficient for blueprint consumers.

### Document consumer pinning by released version, not floating mainline

- TypeScript consumers pin a released package version rather than pulling floating mainline artifacts.
- Go consumers pin released module versions/tags and upgrade deliberately.
- Workspace/local development can still use local sibling repos, but the release policy documents that published consumption must target tagged releases.

Why:

- `P2-T11` is specifically about making released consumption safe and repeatable.
- Floating dependencies would undermine the point of a release boundary.

Alternative considered:

- Allow version ranges or floating install sources as the default baseline.
- Rejected because the blueprint needs deterministic releases first.

### Require a minimal release checklist before tagging

- Before cutting a release, maintainers run the contract validation checks, confirm generation drift is clean, confirm docs are updated, and confirm the package metadata is ready.
- The task should document the checklist even if release automation comes later.

Why:

- A release policy without a checklist is too easy to follow inconsistently.
- This keeps the task useful even before Phase 4 CI/release automation is expanded.

## Risks / Trade-offs

- Manual release steps can drift or be skipped -> Mitigation: document one small checklist and keep the flow simple enough that humans will actually follow it.
- GitHub Packages auth/bootstrap can still be confusing for new consumers -> Mitigation: document the Bun/npm consumer bootstrap pattern explicitly and keep frontend repos compatible with it.
- Matching package versions to tags adds a coordination step during release prep -> Mitigation: make the version-alignment rule explicit and include it in the checklist.
- Go consumer versioning may remain less concrete than npm publishing at first -> Mitigation: document the module/tag expectation now so backend repos have a stable default even before additional automation exists.

## Migration Plan

1. Add the release workflow spec and repo docs in `platform-contracts`.
2. Update the README and package-publishing docs so the tag/package/install contract is visible from the repo entrypoint.
3. Add consumer guidance references for future frontend and backend repos.
4. Validate the documented commands and release checklist against the current repo layout.
5. Archive the change into canonical OpenSpec specs once the task implementation is complete.

## Open Questions

- None currently. The task should keep release execution manual/documented for now rather than adding automation scope before it is needed.
