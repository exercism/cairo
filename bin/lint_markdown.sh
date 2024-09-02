#!/usr/bin/env bash
set -eo pipefail

npx markdownlint-cli2 docs/*.md concepts/**/*.md
