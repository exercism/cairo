test_output=$(scarb cairo-test --include-ignored 2>&1)
results_file="./results.json"

touch "$results_file"

test_output=$(scarb cairo-test --include-ignored 2>&1)
exit_code=$?

if [ ${exit_code} -eq 0 ]; then
    jq -n '{version: 1, status: "pass"}' >"${results_file}"
else
    # Sanitize the output
    # TODO: enable if needed to escape quotes: test_output_inline=$(printf '%s' "${test_output}" | sed -r 's/\"/\\"/g')
    test_output_inline=$(printf '%s' "${test_output}")

    # Try to distinguish between failing tests and errors
    if echo "${test_output_inline}" | grep "error:"; then
        status="error"
        sanitized_test_output=$(echo "$test_output_inline" | awk '/Compiling/{y=1;next}y' | sed -n -e '/error: could not compile/q;p')
    else
        status="fail"
        sanitized_test_output=$(echo "$test_output_inline" | awk '/failures:/{y=1;next}y' | sed -n -e '/Error: test result/q;p' | sed -r 's/   //g')
    fi

    tmp_file=$(mktemp -p .)
    trap 'rm $tmp_file' EXIT INT TERM

    printf "$sanitized_test_output" >"$tmp_file"
    sorted_output=$(sort "$tmp_file")

    jq -n --arg output "${sorted_output}" --arg status "${status}" '{version: 1, status: $status, message: $output}' >"${results_file}"
fi

echo "done"
