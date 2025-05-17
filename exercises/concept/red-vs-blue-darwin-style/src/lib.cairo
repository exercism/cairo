mod red_remote_control_car_team {
    #[derive(Drop)]
    pub struct RemoteControlCar {}

    #[generate_trait]
    pub impl RemoteControlCarImpl of RemoteControlCarTrait {
        fn new(
            motor: Motor, chassis: Chassis, telemetry: Telemetry, runningGear: RunningGear,
        ) -> RemoteControlCar {
            RemoteControlCar {}
        }
    }

    #[derive(Drop)]
    pub struct RunningGear {}

    #[derive(Drop)]
    pub struct Telemetry {}

    #[derive(Drop)]
    pub struct Chassis {}

    #[derive(Drop)]
    pub struct Motor {}
}

#[derive(Drop)]
struct RemoteControlCar {}

#[generate_trait]
impl RemoteControlCarImpl of RemoteControlCarTrait {
    fn new(motor: Motor, chassis: Chassis, telemetry: Telemetry) -> RemoteControlCar {
        RemoteControlCar {}
    }
}

#[derive(Drop)]
struct Telemetry {}

#[derive(Drop)]
struct Chassis {}

#[derive(Drop)]
struct Motor {}

struct CarBuilder {}

#[generate_trait]
impl CarBuilderImpl of CarBuilderTrait {
    fn build_red() -> red_remote_control_car_team::RemoteControlCar {
        red_remote_control_car_team::RemoteControlCarTrait::new(
            red_remote_control_car_team::Motor {},
            red_remote_control_car_team::Chassis {},
            red_remote_control_car_team::Telemetry {},
            red_remote_control_car_team::RunningGear {},
        )
    }

    fn build_blue() -> RemoteControlCar {
        RemoteControlCarTrait::new(Motor {}, Chassis {}, Telemetry {})
    }
}
