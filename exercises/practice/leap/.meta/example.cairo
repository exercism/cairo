fn is_leap_year(year: u64) -> bool {
    has_factor(year, 4) && (!has_factor(year, 100) || has_factor(year, 400))
}

fn has_factor(year: u64, factor: u64) -> bool {
    year % factor == 0
}
