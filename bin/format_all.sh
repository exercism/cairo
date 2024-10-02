#!/usr/bin/env bash
set -eo pipefail

./bin/lint_markdown.sh
./bin/configlet fmt -uy
./bin/format_exercises.sh
