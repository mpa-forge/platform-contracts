#!/usr/bin/env bash

set -euo pipefail

target_branch="${1:-main}"

if ! git rev-parse --verify "${target_branch}" >/dev/null 2>&1; then
	echo "Skipping buf breaking: target branch '${target_branch}' is not available locally."
	exit 0
fi

if ! git cat-file -e "${target_branch}:buf.yaml" 2>/dev/null; then
	echo "Skipping buf breaking: target branch '${target_branch}' does not have a Buf baseline yet."
	exit 0
fi

if ! git ls-tree -r --name-only "${target_branch}" -- proto | grep -q '\.proto$'; then
	echo "Skipping buf breaking: target branch '${target_branch}' has no protobuf sources yet."
	exit 0
fi

buf breaking --against ".git#branch=${target_branch}"
