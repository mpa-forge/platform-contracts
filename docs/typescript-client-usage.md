# TypeScript Client Usage

## Purpose

The generated TypeScript client package gives frontend code a typed contract
surface derived directly from the protobuf definitions in `proto/`.

Current package:

- `@mpa-forge/platform-contracts-client`

Current contract entrypoint:

- `blueprint.user.v1.UserService`

## What The Package Exposes

The package re-exports generated messages and service definitions from:

- `packages/typescript-client/src/gen/blueprint/user/v1/user_pb.ts`
- `packages/typescript-client/src/gen/blueprint/user/v1/user_connect.ts`

Current exported symbols include:

- `UserService`
- `EnsureCurrentUserProfileRequest`
- `EnsureCurrentUserProfileResponse`
- `GetCurrentUserRequest`
- `GetCurrentUserResponse`
- `UserProfile`

## How Frontend Code Uses It

Frontend code should:

1. import the generated service and message types from the package
2. create a Connect transport pointing at the API base URL
3. create a client from the generated service definition
4. call the generated RPC method instead of writing hand-made DTOs or request shapes

Example:

```ts
import { createClient } from "@connectrpc/connect";
import { createConnectTransport } from "@connectrpc/connect-web";
import {
  EnsureCurrentUserProfileRequest,
  GetCurrentUserRequest,
  UserService
} from "@mpa-forge/platform-contracts-client";

const transport = createConnectTransport({
  baseUrl: "http://localhost:8080",
  useBinaryFormat: false
});

const client = createClient(UserService, transport);

await client.ensureCurrentUserProfile(new EnsureCurrentUserProfileRequest());
const response = await client.getCurrentUser(new GetCurrentUserRequest());

console.log(response.user?.displayName);
```

## Local Workspace Usage

Before the package is published, consumers in the shared workspace should use the
generated package directly from the checked-out `platform-contracts` repository.

The consuming application code should still import from:

- `@mpa-forge/platform-contracts-client`

That keeps application code stable when the dependency source later changes from
workspace-local to GitHub Packages.

## Released Package Usage

Released package usage is tied to the contract release workflow.

Release boundary:

- `contracts-vX.Y.Z` tag

Matching package version:

- `X.Y.Z`

Examples:

- `contracts-v0.1.1` -> install `@mpa-forge/platform-contracts-client@0.1.1`
- `contracts-v0.2.0` -> install `@mpa-forge/platform-contracts-client@0.2.0`

Consumers should pin a released package version instead of following floating
mainline artifacts.

### Bun/NPM GitHub Packages Bootstrap

Consumers must authenticate to GitHub Packages without committing credentials.
A typical user-level setup looks like:

```ini
@mpa-forge:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_PACKAGES_TOKEN}
```

Recommended pattern:

- keep registry auth in user-level `.npmrc` or CI environment configuration
- provide `GITHUB_PACKAGES_TOKEN` through local environment or CI secrets
- do not commit registry credentials into the consuming repository

Install examples:

```bash
npm install @mpa-forge/platform-contracts-client@0.1.1
```

```bash
bun add @mpa-forge/platform-contracts-client@0.1.1
```

The consuming frontend code should not need to change when moving from local
workspace usage to GitHub Packages usage.

## Current Scope And Limits

Today this package documents and exports the first generic authenticated user
flow:

- `UserService.EnsureCurrentUserProfile`
- `UserService.GetCurrentUser`

The package is generated and buildable now, but full end-to-end use depends on
later tasks:

- `P2-T04`: API mounts the generated Connect handlers
- `P2-T10`: frontend integrates the generated TypeScript client

Go server usage documentation:

- `docs/go-server-usage.md`
- `docs/consumer-auth-usage.md`
- `docs/contract-release-workflow.md`
