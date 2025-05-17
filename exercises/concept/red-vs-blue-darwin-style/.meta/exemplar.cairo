pub mod red_remote_control_car_team {
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

pub mod blue_remote_control_car_team {
    #[derive(Drop)]
    pub struct RemoteControlCar {}

    #[generate_trait]
    pub impl RemoteControlCarImpl of RemoteControlCarTrait {
        fn new(motor: Motor, chassis: Chassis, telemetry: Telemetry) -> RemoteControlCar {
            RemoteControlCar {}
        }
    }

    #[derive(Drop)]
    pub struct Telemetry {}

    #[derive(Drop)]
    pub struct Chassis {}

    #[derive(Drop)]
    pub struct Motor {}
}

pub mod Combined {
    use super::{red_remote_control_car_team as Red, blue_remote_control_car_team as Blue};

    pub struct CarBuilder {}

    #[generate_trait]
    impl CarBuilderImpl of CarBuilderTrait {
        fn build_red() -> Red::RemoteControlCar {
            Red::RemoteControlCarTrait::new(
                Red::Motor {}, Red::Chassis {}, Red::Telemetry {}, Red::RunningGear {},
            )
        }

        fn build_blue() -> Blue::RemoteControlCar {
            Blue::RemoteControlCarTrait::new(Blue::Motor {}, Blue::Chassis {}, Blue::Telemetry {})
        }
    }
}
