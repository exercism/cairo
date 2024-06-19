#!/usr/bin/env bash
set -eo pipefail

markdownlint_cli_args="$1"

npx markdownlint-cli2 \
    $markdownlint_cli_args \
    docs/*.md \
    concepts/**/*.md \
    exercises/**/*.md
