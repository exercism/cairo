pub fn factors(n: u64) -> Array<u64> {
    let mut val = n;
    let mut out: Array<u64> = ArrayTrait::new();

    if val < 2 {
        return out;
    }
    while val % 2 == 0 {
        out.append(2);
        val /= 2;
    };

    let mut possible = 3;
    while val != 1 {
        while val % possible == 0 {
            out.append(possible);
            val /= possible;
        };
        possible += 2;
    };

    out
}
