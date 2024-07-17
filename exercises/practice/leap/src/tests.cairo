use leap::is_leap_year;

#[test]
fn year_not_divisible_by_4_in_common_year() {
    assert!(!is_leap_year(2015), "2015 is NOT a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_2_not_divisible_by_4_in_common_year() {
    assert!(!is_leap_year(1970), "1970 is NOT a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_4_not_divisible_by_100_in_leap_year() {
    assert!(is_leap_year(1996), "1996 is a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_4_and_5_is_still_a_leap_year() {
    assert!(is_leap_year(1960), "1960 is a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_100_not_divisible_by_400_in_common_year() {
    assert!(!is_leap_year(2100), "2100 is NOT a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_100_but_not_by_3_is_still_not_a_leap_year() {
    assert!(!is_leap_year(1900), "1900 is NOT a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_400_is_leap_year() {
    assert!(is_leap_year(2000), "2000 is a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_400_but_not_by_125_is_still_a_leap_year() {
    assert!(is_leap_year(2400), "2400 is a leap year");
}

#[test]
#[ignore]
fn year_divisible_by_200_not_divisible_by_400_in_common_year() {
    assert!(!is_leap_year(1800), "1800 is NOT a leap year");
}
