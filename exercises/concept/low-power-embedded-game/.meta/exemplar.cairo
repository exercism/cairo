#[generate_trait]
pub impl DivmodImpl of DivmodTrait {
    fn divmod(self: @u16, divisor: u16) -> (u16, u16) {
        (*self / divisor, *self % divisor)
    }
}

#[generate_trait]
pub impl EvensImpl<T, +Drop<T>, +Copy<T>> of EvensTrait<T> {
    fn evens(self: @Array<T>) -> Array<T> {
        let mut result: Array<T> = array![];
        let mut i = 0;
        while i < self.len() {
            if i % 2 == 0 {
                result.append(*self.at(i));
            }
            i += 1;
        };
        result
    }
}

pub type Position = (i16, i16);

#[generate_trait]
pub impl PositionImpl of PositionTrait {
    fn manhattan(self: @Position) -> u16 {
        let (x, y) = *self;
        x.abs() + y.abs()
    }
}

#[generate_trait]
impl AbsImpl of AbsTrait {
    fn abs(self: @i16) -> u16 {
        let val = if *self < 0 {
            *self * -1
        } else {
            *self
        };
        val.try_into().unwrap()
    }
}
