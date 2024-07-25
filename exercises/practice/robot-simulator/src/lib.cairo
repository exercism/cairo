#[derive(Drop, PartialEq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Drop)]
struct Robot {}

#[generate_trait]
pub impl RobotImpl of RobotTrait {
    fn new(x: i32, y: i32, d: Direction) -> Robot {
        // construct a Robot at (x, y) facing {d:?}
        panic!("implement `new`")
    }

    #[must_use]
    fn turn_right(self: Robot) -> Robot {
        panic!()
    }

    #[must_use]
    fn turn_left(self: Robot) -> Robot {
        panic!()
    }

    #[must_use]
    fn advance(self: Robot) -> Robot {
        panic!()
    }

    #[must_use]
    fn instructions(self: Robot, instructions: ByteArray) -> Robot {
        // follow the given sequence of instructions: {instructions}
        panic!("implement `instructions`")
    }

    fn position(self: @Robot) -> (i32, i32) {
        panic!()
    }

    fn direction(self: @Robot) -> @Direction {
        panic!()
    }
}
