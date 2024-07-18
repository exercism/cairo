dir="./exercises/*/*"
for exercise_dir in $dir; do
    echo "updating $exercise_dir"
    slug=$(basename $exercise_dir)
    sed -i "s/%{kebab_slug}/$slug/g" "$exercise_dir/.meta/config.json"
done
