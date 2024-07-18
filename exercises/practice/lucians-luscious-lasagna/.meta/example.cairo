fn expected_minutes_in_oven() -> u32 {
    40
}

fn remaining_minutes_in_oven(actual_minutes_in_oven: u32) -> u32 {
    expected_minutes_in_oven() - actual_minutes_in_oven
}

fn preparation_time_in_minutes(number_of_layers: u32) -> u32 {
    number_of_layers * 2
}

fn elapsed_time_in_minutes(number_of_layers: u32, actual_minutes_in_oven: u32) -> u32 {
    preparation_time_in_minutes(number_of_layers) + actual_minutes_in_oven
}
