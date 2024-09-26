#!/usr/bin/env bash
set -eo pipefail

args=()

[[ $1 ]] && args+=("$@")

npx markdownlint-cli2 --config .markdownlint-cli2.yaml "$args[@]"
