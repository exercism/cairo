dirs="./exercises/*/*"
for test_file in $dirs; do
    tests="$test_file/tests/*"
    kebab_file=${tests[0]}
    kebab_name=$(basename $kebab_file)
    snake_name="${kebab_name//-/_}"
    mv $kebab_file "$test_file/tests/$snake_name"
done
