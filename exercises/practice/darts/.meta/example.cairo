pub fn score(x: i64, y: i64) -> u8 {
    let distance = sqrt(x * x + y * y);
    if distance <= 1 {
        return 10;
    }
    if distance <= 5 {
        return 5;
    }
    if distance <= 10 {
        return 1;
    }

    return 0;
}

fn sqrt(radicand: i64) -> i64 {
    let mut candidate = 1;
    if radicand > 2 {
        while (candidate * candidate) < radicand {
            candidate += 1;
        };
    }

    return candidate;
}
