# @mpa-forge/platform-contracts-client

Generated TypeScript client package for the platform blueprint contract repository.

This package is generated from the protobuf definitions in `proto/` and is intended
for GitHub Packages publishing in later release workflow tasks.

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
  UserService,
} from "@mpa-forge/platform-contracts-client";

const transport = createConnectTransport({
  baseUrl: "http://localhost:8080",
  useBinaryFormat: false,
});

const client = createClient(UserService, transport);
await client.ensureCurrentUserProfile(new EnsureCurrentUserProfileRequest());
const response = await client.getCurrentUser(new GetCurrentUserRequest());
```

More detailed usage notes:

- `../../docs/typescript-client-usage.md`
