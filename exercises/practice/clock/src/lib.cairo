use core::fmt::{Display, Formatter, Error};

#[derive(Drop, PartialEq, Debug)]
struct Clock {
    minutes: u32,
}

impl ClockDisplay of Display<Clock> {
    fn fmt(self: @Clock, ref f: Formatter) -> Result<(), Error> {
        panic!("implement `fmt` to define how the Clock should be displayed as a string")
    }
}

#[generate_trait]
pub impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        panic!("implement `new`")
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        panic!("implement `add_minutes`")
    }

    fn to_string(self: @Clock) -> ByteArray {
        format!("{}", self)
    }
}
