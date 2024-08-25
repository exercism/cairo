pub fn squareOfSum(number: u64) -> u64 {
    let mut sum = 0;
    let mut current = 1;

    loop {
        if current > number {
            break;
        }

        sum += current;
        current += 1;
    };

    return sum * sum;
}

pub fn sumOfSquares(number: u64) -> u64 {
    let mut sum = 0;
    let mut current = 1;

    loop {
        if current > number {
            break;
        }

        sum += current * current;
        current += 1;
    };

    return sum;
}

pub fn differenceOfSquares(number: u64) -> u64 {
    return squareOfSum(number) - sumOfSquares(number);
}
