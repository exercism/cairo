use triangle::{is_equilateral, is_isosceles, is_scalene};

// Equilateral triangles

#[test]
#[ignore]
fn equilateral_all_sides_are_equal() {
    let sides: [u64; 3] = [2, 2, 2];
    assert!(is_equilateral(sides));
}

#[test]
#[ignore]
fn equilateral_any_side_is_unequal() {
    let sides: [u64; 3] = [2, 3, 2];
    assert!(!is_equilateral(sides));
}

#[test]
#[ignore]
fn equilateral_no_sides_are_equal() {
    let sides: [u64; 3] = [5, 4, 6];
    assert!(!is_equilateral(sides));
}

#[test]
#[ignore]
fn equilateral_all_zero_sides_is_not_a_triangle() {
    let sides: [u64; 3] = [0, 0, 0];
    assert!(!is_equilateral(sides));
}

// Isosceles triangles

#[test]
#[ignore]
fn isosceles_last_two_sides_are_equal() {
    let sides: [u64; 3] = [3, 4, 4];
    assert!(is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_first_two_sides_are_equal() {
    let sides: [u64; 3] = [4, 4, 3];
    assert!(is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_first_and_last_sides_are_equal() {
    let sides: [u64; 3] = [4, 3, 4];
    assert!(is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_equilateral_triangles_are_also_isosceles() {
    let sides: [u64; 3] = [4, 4, 4];
    assert!(is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_no_sides_are_equal() {
    let sides: [u64; 3] = [2, 3, 4];
    assert!(!is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_first_triangle_inequality_violation() {
    let sides: [u64; 3] = [1, 1, 3];
    assert!(!is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_second_triangle_inequality_violation() {
    let sides: [u64; 3] = [1, 3, 1];
    assert!(!is_isosceles(sides));
}

#[test]
#[ignore]
fn isosceles_third_triangle_inequality_violation() {
    let sides: [u64; 3] = [3, 1, 1];
    assert!(!is_isosceles(sides));
}

// Scalene triangles

#[test]
#[ignore]
fn scalene_no_sides_are_equal() {
    let sides: [u64; 3] = [5, 4, 6];
    assert!(is_scalene(sides));
}

#[test]
#[ignore]
fn scalene_all_sides_are_equal() {
    let sides: [u64; 3] = [4, 4, 4];
    assert!(!is_scalene(sides));
}

#[test]
#[ignore]
fn scalene_first_and_second_sides_are_equal() {
    let sides: [u64; 3] = [4, 4, 3];
    assert!(!is_scalene(sides));
}

#[test]
#[ignore]
fn scalene_first_and_third_sides_are_equal() {
    let sides: [u64; 3] = [3, 4, 3];
    assert!(!is_scalene(sides));
}

#[test]
#[ignore]
fn scalene_second_and_third_sides_are_equal() {
    let sides: [u64; 3] = [4, 3, 3];
    assert!(!is_scalene(sides));
}

#[test]
#[ignore]
fn scalene_may_not_violate_triangle_inequality() {
    let sides: [u64; 3] = [7, 3, 2];
    assert!(!is_scalene(sides));
}
