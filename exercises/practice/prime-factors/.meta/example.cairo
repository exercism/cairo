pub fn factors(n: u64) -> Array<u64> {
    let mut val = n;
    let mut out: Array<u64> = ArrayTrait::new();

    let mut possible = 2;
    while val > 1 {
        while val % possible == 0 {
            out.append(possible);
            val /= possible;
        };
        possible += 1;
    };

    out
}
