#!/usr/bin/env bash
set -eo pipefail

# Format existing exercises using scarb fmt

repo=$(git rev-parse --show-toplevel)

# traverse either concept or practice exercise
# directory and format Cairo files
format_exercises() {
    exercises_path="$repo/exercises/$1"
    source_file_name="$2"
    for exercise_dir in "$exercises_path"/*; do
        cd "$exercise_dir"
        config_file="$exercise_dir/.meta/config.json"
        if jq --exit-status '.custom?."allowed-to-not-compile"?' "$config_file"; then
            exercise=$(basename "$exercise_dir")
            echo "$exercise's stub is allowed to not compile"
            # exit the subshell successfully to continue
            # to the next exercise directory
            exit 0
        fi
        # scarb fmt cannot currently format individual files, so we have to
        # temporarily move the solution files into the Cairo package, where
        # 'scarb fmt' can format it as well
        tmp_file=$(mktemp "./src/tmp.XXXXXXXXXXX.cairo")
        file_name=".meta/$source_file_name.cairo"
        if [ -f "$file_name" ]; then
            cp "$file_name" "$tmp_file"
        fi
        scarb fmt
        # move the solution file back
        if [ -f "$file_name" ]; then
            cp "$tmp_file" "$file_name"
        fi
        rm $tmp_file
    done
}

# https://github.com/exercism/docs/blob/main/anatomy/tracks/concept-exercises.md#file-exemplar-implementation
# format_exercises "concept" "exemplar"
# https://github.com/exercism/docs/blob/main/anatomy/tracks/practice-exercises.md#file-example-implementation
format_exercises "practice" "example"
