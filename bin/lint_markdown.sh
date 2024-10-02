#!/usr/bin/env bash
set -eo pipefail

npx prettier --write "concepts/**/*.md" "exercises/concept/**/*.md" "exercises/practice/*/.docs/{hints.md,instructions.append.md}"
npx markdownlint-cli2 --fix "concepts/**/*.md" "exercises/concept/**/*.md" "exercises/practice/*/.docs/{hints.md,instructions.append.md}"
