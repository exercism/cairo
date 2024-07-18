// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

#[derive(Drop, PartialEq, Debug)]
enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Drop)]
struct Robot {}

#[generate_trait]
impl RobotImpl of RobotTrait {
    fn new(x: i32, y: i32, d: Direction) -> Robot {
        panic!("Create a robot at (x, y) facing {d:?}")
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
        panic!("Follow the given sequence of instructions: {instructions}")
    }

    fn position(self: @Robot) -> (i32, i32) {
        panic!()
    }

    fn direction(self: @Robot) -> @Direction {
        panic!()
    }
}
