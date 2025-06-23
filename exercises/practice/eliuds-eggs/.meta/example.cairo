pub fn eggCount(number: u64) -> u64 {
    let mut count = 0;

    let mut current = number;
    loop {
        if current == 0 {
            break;
        }

        if current % 2 == 1 {
            count += 1;
        }

        current /= 2;
    };

    count
}
