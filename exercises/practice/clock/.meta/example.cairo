use core::fmt::{Display, Error, Formatter};

#[derive(Drop, PartialEq, Debug)]
struct Clock {
    minutes: u32,
}

impl ClockDisplay of Display<Clock> {
    fn fmt(self: @Clock, ref f: Formatter) -> Result<(), Error> {
        let hours = double_digit(*self.minutes / 60);
        let mins = double_digit(*self.minutes % 60);
        write!(f, "{hours}:{mins}")
    }
}

fn double_digit(n: u32) -> ByteArray {
    if n < 10 {
        format!("0{n}")
    } else {
        format!("{n}")
    }
}

#[generate_trait]
pub impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        Self::build(hour * 60 + minute)
    }

    fn build(minutes: i32) -> Clock {
        let mut mins = minutes;
        while mins < 0 {
            mins += 1440;
        }
        let mins: u32 = mins.try_into().unwrap();
        Clock { minutes: mins % 1440 }
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        Self::build(self.minutes.try_into().unwrap() + minutes)
    }

    fn to_string(self: @Clock) -> ByteArray {
        format!("{}", self)
    }
}
