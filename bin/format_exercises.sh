#!/usr/bin/env bash
set -eo pipefail

# Format existing exercises using scarb fmt

repo=$(git rev-parse --show-toplevel)

# traverse either concept or practice exercise
# directory and format Cairo files
format_exercises() {
    exercises_path="$repo/exercises/$1/*"
    source_file_name="$2"

    for exercise_dir in $exercises_path; do
        cd "$exercise_dir" || exit 1

        exercise=$(basename "$exercise_dir")
        
        # scarb fmt cannot currently format individual files, so we have to
        # temporarily move the solution files into the Cairo package, where
        # 'scarb fmt' can format it as well
        tmp_file=$(mktemp "./src/tmp.XXXXXXXXXXX.cairo")

        config_file="$exercise_dir/.meta/config.json"
        if jq --exit-status '.custom?."allowed-to-not-compile"?' "$config_file"; then
            echo "$exercise's stub is allowed to not compile"
            # exit the subshell successfully to continue
            # to the next exercise directory
            exit 0
        fi

        solution_file=".meta/$source_file_name.cairo"
        if [ -z "$solution_file" ]; then
            echo "Could not find solution file for $exercise"
            exit 1
        fi

        # move the solution file into the package       
        cp "$solution_file" "$tmp_file"

        scarb fmt

        # move the solution file back
        cp "$tmp_file" "$solution_file"
        
        rm "$tmp_file"
    done
}

# https://github.com/exercism/docs/blob/main/anatomy/tracks/concept-exercises.md#file-exemplar-implementation
format_exercises "concept" "exemplar"
# https://github.com/exercism/docs/blob/main/anatomy/tracks/practice-exercises.md#file-example-implementation
format_exercises "practice" "example"
