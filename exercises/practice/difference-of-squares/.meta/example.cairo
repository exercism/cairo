pub fn square_of_sum(number: u64) -> u64 {
    let mut sum = 0;
    for current in 1..(number + 1) {
        sum += current;
    }
    sum * sum
}

pub fn sum_of_squares(number: u64) -> u64 {
    let mut sum = 0;
    for current in 1..(number + 1) {
        sum += current * current;
    }
    sum
}

pub fn difference_of_squares(number: u64) -> u64 {
    square_of_sum(number) - sum_of_squares(number)
}
