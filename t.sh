dir="./exercises/*/*"
for exercise_dir in $dir; do
    echo "updating $exercise_dir"
    slug=$(basename $exercise_dir)
    mkdir -p "$exercise_dir/tests"
    mv "$exercise_dir/src/tests.cairo" "$exercise_dir/tests/$slug.cairo"
    sed -i '/#\[cfg(test)\]/,$d' "$exercise_dir/src/lib.cairo"
    sed -i '/#\[cfg(test)\]/,$d' "$exercise_dir/.meta/example.cairo"
done
