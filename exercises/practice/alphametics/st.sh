#!/bin/bash

# Print an empty line
echo

# Run the scarb test command and process the output
scarb -q cairo-test --include-ignored |
    sed -e 's/test alphametics_integrationtest::alphametics:://g' \
        -e '/^testing alphametics \.\.\./d' \
        -e '/^running [0-9]\+ tests$/d' \
        -e '/^failures:/,$d' \
        -e 's/\bok\b/\x1b[32mok\x1b[0m/g' \
        -e 's/\bfail\b/\x1b[31mfail\x1b[0m/g' \
        -e '/^Error: test result: FAILED\..*/d' |
    awk 'sort {print | "sort"} !sort {print}'
