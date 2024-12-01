#!/usr/bin/env bash
set -eo pipefail

# Format existing exercises using scarb fmt

repo=$(git rev-parse --show-toplevel)

# traverse both concept or practice exercises
# directory and format Cairo files
exercises="$repo/exercises/*/*"

for exercise_dir in $exercises; do
    cd "$exercise_dir"

    exercise=$(basename "$exercise_dir")

    if [ ! -s "$exercise_dir/Scarb.toml" ]; then
        echo "Exercise $exercise is just a stub, skipping"
        continue
    fi

    # scarb fmt cannot currently format individual files, so we have to
    # temporarily move the solution files into the Cairo package, where
    # 'scarb fmt' can format it as well
    tmp_file=$(mktemp "./src/tmp.XXXXXXXXXXX.cairo")
    trap 'rm -f $tmp_file' EXIT INT TERM

    if [ -f ".meta/example.cairo" ]; then
        solution_file=".meta/example.cairo"
    elif [ -f ".meta/exemplar.cairo" ]; then
        solution_file=".meta/exemplar.cairo"
    else
        echo "Could not locate example implementation for $exercise"
        exit 1
    fi

    # move the solution file into the package
    cp "$solution_file" "$tmp_file"

    scarb fmt "$@"

    # move the solution file back
    cp "$tmp_file" "$solution_file"

    rm "$tmp_file"
done
