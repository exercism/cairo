use core::fmt::{Display, Formatter, Error};

#[derive(Drop, PartialEq, Debug)]
pub struct Clock {
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
impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        ClockImpl::build(hour * 60 + minute)
    }

    fn build(minutes: i32) -> Clock {
        let mut mins = minutes;
        while mins < 0 {
            mins += 1440;
        };
        let mins: u32 = mins.try_into().unwrap();
        Clock { minutes: mins % 1440, }
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        ClockImpl::build(self.minutes.try_into().unwrap() + minutes)
    }

    fn to_string(self: @Clock) -> ByteArray {
        let mut formatter: Formatter = Default::default();
        Display::fmt(self, ref formatter).unwrap();
        formatter.buffer
    }
}

#[cfg(test)]
mod tests;
