pub fn is_equilateral(sides: [u64; 3]) -> bool {
    is_triangle(@sides) && unique_sides(@sides) == 1
}

pub fn is_isosceles(sides: [u64; 3]) -> bool {
    is_triangle(@sides) && unique_sides(@sides) < 3
}

pub fn is_scalene(sides: [u64; 3]) -> bool {
    is_triangle(@sides) && unique_sides(@sides) == 3
}

fn unique_sides(sides: @[u64; 3]) -> u64 {
    let [a, b, c] = sides;

    if a == b && b == c {
        1
    } else if a == b || b == c || a == c {
        2
    } else {
        3
    }
}

fn is_triangle(sides: @[u64; 3]) -> bool {
    let [a, b, c] = sides;

    all_sides_positive(a, b, c) && satisifies_inequality(a, b, c)
}

fn all_sides_positive(a: @u64, b: @u64, c: @u64) -> bool {
    *a > 0 && *b > 0 && *c > 0
}

fn satisifies_inequality(a: @u64, b: @u64, c: @u64) -> bool {
    *a + *b > *c && *a + *c > *b && *b + *c > *a
}
