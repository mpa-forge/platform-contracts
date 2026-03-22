#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export PATH="${repo_root}/.bin:${repo_root}/node_modules/.bin:${PATH}"

cd "${repo_root}"
buf generate

