# @mpa-forge/platform-contracts-client

Generated TypeScript client package for the platform blueprint contract repository.

This package is generated from the protobuf definitions in `proto/` and is
published through the contract release workflow documented in:

- `../../docs/contract-release-workflow.md`

## Current Exports

The package currently re-exports:

- `UserService`
- `EnsureCurrentUserProfileRequest`
- `EnsureCurrentUserProfileResponse`
- `GetCurrentUserRequest`
- `GetCurrentUserResponse`
- `UserProfile`

These come from the generated files under:

- `src/gen/blueprint/user/v1/`

## Usage Pattern

Frontend code should import generated symbols from the package and create a
Connect client with a browser transport.

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
```

## Release And Version Alignment

The package version must match the `X.Y.Z` version of the corresponding
`contracts-vX.Y.Z` release tag.

Examples:

- `contracts-v0.1.1` -> package version `0.1.1`
- `contracts-v0.2.0` -> package version `0.2.0`

The package is published to:

- `https://npm.pkg.github.com`

Consumers should install a released package version rather than following a
floating mainline state.

## Consumer Bootstrap

GitHub Packages auth should be provided through user-level or CI configuration,
not committed credentials.

Typical registry setup:

```ini
@mpa-forge:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_PACKAGES_TOKEN}
```

Install example:

```bash
npm install @mpa-forge/platform-contracts-client@0.1.1
```

More detailed usage notes:

- `../../docs/typescript-client-usage.md`
