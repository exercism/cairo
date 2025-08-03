#!/usr/bin/env bash

# Synopsis:
# Test the student's solution.

# Example: test two-fer
# ./bin/test two-fer

set -eo pipefail

curDir=$(pwd)
repo=$(git rev-parse --show-toplevel)

if [ "$#" -ne 1 ]; then
    echo "Error: Incorrect number of arguments. This script requires exactly one argument."
    echo "Example: './bin/test two-fer'"
    exit 1
fi
    
slug="$1"

if [ -d "$repo/exercises/concept/$slug" ]; then
    exercisePath="$repo/exercises/concept/$slug"
elif [ -d "$repo/exercises/practice/$slug" ]; then
    exercisePath="$repo/exercises/practice/$slug"
else
    echo "No such exercise: $slug"
    exit 1
fi

# Exercism sets a timeout limit for tests
timeout 20 scarb --manifest-path "$exercisePath/Scarb.toml" cairo-test --include-ignored --test-kind integration || (echo "$slug timed out" && exit 1)
