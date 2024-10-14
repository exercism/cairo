const EXPECTED_MINUTES_IN_OVEN: u32 = 40;

pub fn expected_minutes_in_oven() -> u32 {
    EXPECTED_MINUTES_IN_OVEN
}

pub fn remaining_minutes_in_oven(actual_minutes_in_oven: u32) -> u32 {
    let remaining_minutes = expected_minutes_in_oven() - actual_minutes_in_oven;
    remaining_minutes
}

pub fn preparation_time_in_minutes(number_of_layers: u32) -> u32 {
    let number_of_layers = number_of_layers * 2;
    number_of_layers
}

pub fn elapsed_time_in_minutes(number_of_layers: u32, actual_minutes_in_oven: u32) -> u32 {
    let mut elapsed_time = preparation_time_in_minutes(number_of_layers);
    elapsed_time += actual_minutes_in_oven;
    elapsed_time
}
