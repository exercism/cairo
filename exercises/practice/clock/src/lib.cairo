#[derive(Drop, PartialEq, Debug)]
pub struct Clock {}

#[generate_trait]
impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        panic!("implement `new`")
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        panic!("implement `add_minutes`")
    }

    fn to_string(self: @Clock) -> ByteArray {
        panic!("implement `to_string`")
    }
}

#[cfg(test)]
mod tests;
