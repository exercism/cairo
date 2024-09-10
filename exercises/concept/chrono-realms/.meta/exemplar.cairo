use core::traits::{Add, Sub, PartialOrd};

// Define the TimeShard struct
#[derive(Drop, Debug, PartialEq)]
pub struct TimeShard {
    pub value: i32,
}

// Implement Add for TimeShard
impl TimeShardAdd of Add<TimeShard> {
    fn add(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        TimeShard { value: lhs.value + rhs.value }
    }
}

// Implement Sub for TimeShard
impl TimeShardSub of Sub<TimeShard> {
    fn sub(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        TimeShard { value: lhs.value - rhs.value }
    }
}

// Implement PartialEq is already derived, so no need for manual implementation
impl TimeShardPartialOrd of PartialOrd<TimeShard> {
    fn le(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value <= rhs.value
    }
    fn ge(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value >= rhs.value
    }
    fn lt(lhs: TimeShard, rhs: TimeShard) -> bool {
        !Self::ge(lhs, rhs)
    }
    fn gt(lhs: TimeShard, rhs: TimeShard) -> bool {
        !Self::le(lhs, rhs)
    }
}
