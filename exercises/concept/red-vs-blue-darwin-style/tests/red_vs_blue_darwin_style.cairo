use red_vs_blue_darwin_style::combined::{CarBuilder, CarBuilderTrait};

#[test]
fn module_for_car_builder_is_combined() {
    let _ = CarBuilder {};
}

#[test]
#[ignore]
fn module_for_car_builder_has_method_build_blue() {
    let car_builder_type = CarBuilder {};
    let _ = car_builder_type.build_blue();
}

#[test]
#[ignore]
fn module_for_car_builder_has_method_build_red() {
    let car_builder_type = CarBuilder {};
    let _ = car_builder_type.build_red();
}

#[test]
#[ignore]
fn module_for_car_builder_returns_blue_type() {
    let car_builder_type = CarBuilder {};
    let _: red_vs_blue_darwin_style::blue_remote_control_car_team::RemoteControlCar =
        car_builder_type
        .build_blue();
}

#[test]
#[ignore]
fn module_for_car_builder_returns_red_type() {
    let car_builder_type = CarBuilder {};
    let _: red_vs_blue_darwin_style::red_remote_control_car_team::RemoteControlCar =
        car_builder_type
        .build_red();
}
