pub fn steps(number: usize) -> usize {
    assert!(number != 0, "Only positive integers are allowed");

    let mut working = number;
    let mut count = 0;

    while working > 1 {
        if working % 2 == 0 {
            working /= 2;
        } else {
            working = 3 * working + 1;
        }
        count += 1;
    };

    return count;
}
