# Go Server Usage

## Purpose

The generated Go artifacts let backend services implement the protobuf contract
without hand-writing DTOs, route contracts, or transport-specific request and
response shapes.

Current contract entrypoint:

- `blueprint.user.v1.UserService`

## Generated Go Outputs

Current generated Go files:

- `gen/go/blueprint/user/v1/user.pb.go`
- `gen/go/blueprint/user/v1/userv1connect/user.connect.go`

These provide:

- generated protobuf message types
- generated Connect client and handler types
- generated route constants and service names

## What Backend Code Imports

Backend code typically imports two generated packages:

```go
import (
    userv1 "github.com/mpa-forge/platform-contracts/gen/go/blueprint/user/v1"
    "github.com/mpa-forge/platform-contracts/gen/go/blueprint/user/v1/userv1connect"
)
```

Use:

- `userv1` for generated request/response/message types
- `userv1connect` for the generated service interface and handler constructor

## Service Implementation Pattern

The generated Connect code defines a Go interface for the service:

- `userv1connect.UserServiceHandler`

Your API implements that interface with normal Go code.

Example:

```go
package userserver

import (
    "context"

    "connectrpc.com/connect"
    userv1 "github.com/mpa-forge/platform-contracts/gen/go/blueprint/user/v1"
)

type Server struct{}

func (s *Server) GetCurrentUser(
    ctx context.Context,
    req *connect.Request[userv1.GetCurrentUserRequest],
) (*connect.Response[userv1.GetCurrentUserResponse], error) {
    return connect.NewResponse(&userv1.GetCurrentUserResponse{
        User: &userv1.UserProfile{
            UserId:      "user_123",
            Email:       "user@example.com",
            DisplayName: "Example User",
            Role:        "user",
        },
    }), nil
}
```

## Mounting In The API Router

The generated code is not tied to `chi`.

It generates a standard `http.Handler`, so the backend can mount it with:

- `chi`
- plain `net/http`
- another router compatible with `http.Handler`

In the current blueprint, the API runtime uses `chi`, so the expected mounting
shape is:

```go
package api

import (
    "github.com/go-chi/chi/v5"
    "github.com/mpa-forge/platform-contracts/gen/go/blueprint/user/v1/userv1connect"
)

func NewRouter(userHandler userv1connect.UserServiceHandler) *chi.Mux {
    router := chi.NewRouter()

    path, handler := userv1connect.NewUserServiceHandler(userHandler)
    router.Mount(path, handler)

    return router
}
```

## Released Contract Consumption

When consuming `platform-contracts` outside the local sibling-workspace setup,
Go maintainers should treat released contract versions as the upgrade boundary.

That means:

- prefer deliberate upgrades against released `platform-contracts` versions
- avoid treating `main` as the default reusable dependency source
- keep Go consumer upgrades explicit in PRs or dependency-update work

This release expectation is documented in:

- `docs/contract-release-workflow.md`

## Why `chi` Is Separate From Code Generation

The generated code depends on:

- `connect-go`
- standard `net/http`

It does not depend on `chi`.

That means:

- protobuf and code generation define the contract
- Connect provides generated HTTP handlers and clients
- `chi` is only the application router chosen by the API runtime

This separation keeps the contract portable even if the API router changes later.

## Generated Handler Behavior

The generated handler constructor:

- `userv1connect.NewUserServiceHandler(...)`

returns:

- the mount path
- an `http.Handler`

For the current contract, the generated procedure paths include:

- `/blueprint.user.v1.UserService/EnsureCurrentUserProfile`
- `/blueprint.user.v1.UserService/GetCurrentUser`

Backend code should not hand-build these paths when the generated constants and
handler constructor already provide the contract-safe values.

## Current Scope And Limits

Today this documents the first generic authenticated user flow:

- `UserService.EnsureCurrentUserProfile`
- `UserService.GetCurrentUser`

The real API runtime wiring still belongs to later tasks:

- `P2-T04`: API runtime skeleton with `chi` + `connect-go`
- `P2-T05`: Clerk JWT verification middleware
