#[derive(Drop, Debug, Copy, PartialEq)]
enum Direction {
    North,
    East,
    South,
    West,
}

#[generate_trait]
impl DirectionImpl of DirectionTrait {
    fn previous_clockwise(self: Direction) -> Direction {
        match self {
            Direction::North => Direction::West,
            Direction::East => Direction::North,
            Direction::South => Direction::East,
            Direction::West => Direction::South,
        }
    }

    fn next_clockwise(self: Direction) -> Direction {
        match self {
            Direction::North => Direction::East,
            Direction::East => Direction::South,
            Direction::South => Direction::West,
            Direction::West => Direction::North,
        }
    }
}

#[derive(Drop, Copy)]
struct Position {
    x: i32,
    y: i32,
}

#[generate_trait]
impl PositionImpl of PositionTrait {
    fn new(x: i32, y: i32) -> Position {
        Position { x, y }
    }

    fn advance(self: Position, direction: @Direction) -> Position {
        match *direction {
            Direction::North => PositionImpl::new(self.x, self.y + 1),
            Direction::South => PositionImpl::new(self.x, self.y - 1),
            Direction::East => PositionImpl::new(self.x + 1, self.y),
            Direction::West => PositionImpl::new(self.x - 1, self.y),
        }
    }
}

#[derive(Drop, Copy)]
struct Robot {
    position: Position,
    direction: Direction,
}

#[generate_trait]
impl RobotImpl of RobotTrait {
    fn new(x: i32, y: i32, d: Direction) -> Robot {
        RobotTrait::build(PositionTrait::new(x, y), d)
    }

    fn build(position: Position, direction: Direction) -> Robot {
        Robot { position, direction, }
    }

    #[must_use]
    fn turn_right(self: Robot) -> Robot {
        RobotTrait::build(self.position, self.direction.next_clockwise())
    }

    #[must_use]
    fn turn_left(self: Robot) -> Robot {
        RobotTrait::build(self.position, self.direction.previous_clockwise())
    }

    #[must_use]
    fn advance(self: Robot) -> Robot {
        RobotTrait::build(self.position.advance(@self.direction), self.direction)
    }

    #[must_use]
    fn instructions(self: Robot, instructions: ByteArray) -> Robot {
        let mut robot = self.clone();
        let mut i = 0;
        loop {
            match instructions.at(i) {
                Option::None => { break robot; },
                Option::Some(instruction) => {
                    robot = robot.execute(instruction.into());
                    i += 1;
                }
            }
        }
    }

    fn position(self: @Robot) -> (i32, i32) {
        (*self.position.x, *self.position.y)
    }

    fn direction(self: @Robot) -> @Direction {
        self.direction
    }

    #[must_use]
    fn execute(self: Robot, command: felt252) -> Robot {
        if command == 'R' {
            self.turn_right()
        } else if command == 'L' {
            self.turn_left()
        } else if command == 'A' {
            self.advance()
        } else {
            self
        }
    }
}

#[cfg(test)]
mod tests;
