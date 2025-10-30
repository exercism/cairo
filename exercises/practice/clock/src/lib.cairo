use core::fmt::{Display, Error, Formatter};

#[derive(Drop, PartialEq, Debug)]
struct Clock {
    minutes: u32,
}

impl ClockDisplay of Display<Clock> {
    fn fmt(self: @Clock, ref f: Formatter) -> Result<(), Error> {
        // define how the Clock should be converted to a string
        panic!("implement `fmt`")
    }
}

#[generate_trait]
pub impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        // construct a new Clock struct
        panic!("implement `new`")
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        // adds {minutes} to the current Clock and returns the result as a new Clock
        panic!("implement `add_minutes`")
    }

    fn to_string(self: @Clock) -> ByteArray {
        format!("{}", self)
    }
}
