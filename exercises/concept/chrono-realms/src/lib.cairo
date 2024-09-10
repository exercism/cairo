use core::traits::{Add, Sub, PartialOrd};

// Define the TimeShard struct
#[derive(Drop, Debug, PartialEq)]
pub struct TimeShard {
    pub value: i32,
}

// Implement Add for TimeShard
impl TimeShardAdd of Add<TimeShard> {
    fn add(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        panic!()
    }
}

// Implement Sub for TimeShard
impl TimeShardSub of Sub<TimeShard> {
    fn sub(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        panic!()
    }
}

// Implement PartialEq is already derived, so no need for manual implementation
impl TimeShardPartialOrd of PartialOrd<TimeShard> {
    fn le(lhs: TimeShard, rhs: TimeShard) -> bool {
        panic!()
    }
    fn ge(lhs: TimeShard, rhs: TimeShard) -> bool {
        panic!()
    }
    fn lt(lhs: TimeShard, rhs: TimeShard) -> bool {
        panic!()
    }
    fn gt(lhs: TimeShard, rhs: TimeShard) -> bool {
        panic!()
    }
}
