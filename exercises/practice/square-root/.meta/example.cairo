pub fn sqrt(radicand: u64) -> u64 {
    let mut candidate = 1;
    if radicand > 2 {
        while (candidate * candidate) < radicand {
            candidate += 1;
        };
    }
    candidate
}
