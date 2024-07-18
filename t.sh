# dir="./exercises/*/*"
# for exercise_dir in $dir; do
#     echo "updating $exercise_dir"
#     slug=$(basename $exercise_dir)
#     mkdir "$exercise_dir/tests"
#     mv "$exercise_dir/src/tests.cairo" "$exercise_dir/tests/$slug.cairo"

# done

dir="./exercises/practice/allergies"
sed -n -e '/\#\[cfg\(test\)\]/,$d' "$dir/src/lib.cairo"
