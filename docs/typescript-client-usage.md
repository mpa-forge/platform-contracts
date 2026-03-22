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
  GetCurrentUserRequest,
  UserService,
} from "@mpa-forge/platform-contracts-client";

const transport = createConnectTransport({
  baseUrl: "http://localhost:8080",
  useBinaryFormat: false,
});

const client = createClient(UserService, transport);

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

## Published Package Usage

After the release workflow is implemented, the same package will be consumed from
GitHub Packages.

The intended consumer behavior does not change:

- install `@mpa-forge/platform-contracts-client`
- keep importing the generated service and messages from the package
- keep `@connectrpc/connect-web` as the browser transport dependency in the frontend

## Current Scope And Limits

Today this package documents and exports the first generic authenticated endpoint:

- `UserService.GetCurrentUser`

The package is generated and buildable now, but full end-to-end use depends on
later tasks:

- `P2-T04`: API mounts the generated Connect handlers
- `P2-T10`: frontend integrates the generated TypeScript client

Go server usage documentation:

- `docs/go-server-usage.md`
- `docs/consumer-auth-usage.md`
