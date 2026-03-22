#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${GO_BIN:-}" ]]; then
  exec "${GO_BIN}" "$@"
fi

if [[ -x "/c/Program Files/Go/bin/go.exe" ]]; then
  exec "/c/Program Files/Go/bin/go.exe" "$@"
fi

if command -v go >/dev/null 2>&1; then
  exec "$(command -v go)" "$@"
fi

echo "Go is required for protobuf Go code generation and validation." >&2
exit 1

