#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bin_dir="${repo_root}/.bin"

mkdir -p "${bin_dir}"

GOBIN="${bin_dir}" "${repo_root}/scripts/go-run.sh" install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.11
GOBIN="${bin_dir}" "${repo_root}/scripts/go-run.sh" install connectrpc.com/connect/cmd/protoc-gen-connect-go@v1.19.1
