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
        // update the direction of the Robot to the right
        panic!("implement `turn_right`")
    }

    #[must_use]
    fn turn_left(self: Robot) -> Robot {
        // update the direction of the Robot to the left
        panic!("implement `turn_left`")
    }

    #[must_use]
    fn advance(self: Robot) -> Robot {
        // move the Robot by 1 along the 'x' or 'y' axis, depending on its direction
        panic!("implement `advance`")
    }

    #[must_use]
    fn instructions(self: Robot, instructions: ByteArray) -> Robot {
        // follow the given sequence of instructions: {instructions}
        panic!("implement `instructions`")
    }

    fn position(self: @Robot) -> (i32, i32) {
        // return Robot's current (x, y) position
        panic!("implement `position`")
    }

    fn direction(self: @Robot) -> @Direction {
        // return Robot's current direction
        panic!("implement `direction`")
    }
}
