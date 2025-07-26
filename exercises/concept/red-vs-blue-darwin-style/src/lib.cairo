#[derive(Drop)]
pub struct RedRemoteControlCar {}

#[generate_trait]
pub impl RedRemoteControlCarImpl of RedRemoteControlCarTrait {
    fn new(
        motor: RedMotor, chassis: RedChassis, telemetry: RedTelemetry, runningGear: RedRunningGear,
    ) -> RedRemoteControlCar {
        RedRemoteControlCar {}
    }
}

#[derive(Drop)]
pub struct RedRunningGear {}

#[derive(Drop)]
pub struct RedTelemetry {}

#[derive(Drop)]
pub struct RedChassis {}

#[derive(Drop)]
pub struct RedMotor {}

#[derive(Drop)]
struct BlueRemoteControlCar {}

#[generate_trait]
impl BlueRemoteControlCarImpl of BlueRemoteControlCarTrait {
    fn new(
        motor: BlueMotor, chassis: BlueChassis, telemetry: BlueTelemetry,
    ) -> BlueRemoteControlCar {
        BlueRemoteControlCar {}
    }
}

#[derive(Drop)]
struct BlueTelemetry {}

#[derive(Drop)]
struct BlueChassis {}

#[derive(Drop)]
struct BlueMotor {}

struct CarBuilder {}

#[generate_trait]
impl CarBuilderImpl of CarBuilderTrait {
    fn build_red() -> RedRemoteControlCar {
        RedRemoteControlCarTrait::new(
            RedMotor {}, RedChassis {}, RedTelemetry {}, RedRunningGear {},
        )
    }

    fn build_blue() -> BlueRemoteControlCar {
        BlueRemoteControlCarTrait::new(BlueMotor {}, BlueChassis {}, BlueTelemetry {})
    }
}
