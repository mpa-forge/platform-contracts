# Consumer Auth Usage

## Purpose

This document describes the auth contract that API consumers should assume when
calling protected procedures generated from `platform-contracts`.

Current protected contract:

- service: `blueprint.user.v1.UserService`
- procedure: `GetCurrentUser`

## Who Should Read This

- frontend developers consuming the generated TypeScript client
- agents working from consumer repos such as `frontend-web`
- backend consumers using generated Go clients later

Implementation details for how the API verifies tokens live in
`backend-api`. Consumer code should treat this file as the source of truth for
the request contract and error semantics.

## Bearer Token Requirement

Protected procedures require:

- `Authorization: Bearer <Clerk session token>`

The client must send a valid Clerk-issued bearer token on each protected API
request.

## Claim Contract

The Phase 2 baseline API uses these token claims:

- required identity claim:
  - `sub`
- optional profile claims:
  - `email`
  - `display_name`
  - `given_name`
  - `family_name`
- optional role claims:
  - `role`
  - `roles`

Role behavior:

- if no recognized role claim is present, the API defaults to `user`
- recognized roles are:
  - `user`
  - `admin`
- if a role claim is present but does not map to `user` or `admin`, the API
  rejects the request

## Error Semantics

- `401 Unauthorized`
  - missing bearer token
  - malformed bearer token
  - invalid JWT signature
  - wrong issuer
  - wrong audience
  - expired or otherwise invalid token
- `403 Forbidden`
  - token is valid, but the role claim does not map to an allowed internal role

## TypeScript Client Example

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
  interceptors: [
    (next) => async (req) => {
      req.header.set("Authorization", `Bearer ${sessionToken}`);
      return next(req);
    },
  ],
});

const client = createClient(UserService, transport);
const response = await client.getCurrentUser(new GetCurrentUserRequest());
```

## Related Docs

- `docs/typescript-client-usage.md`
- `docs/go-server-usage.md`
