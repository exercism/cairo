#[generate_trait]
pub impl DivmodImpl of DivmodTrait {
    fn divmod(self: @u16, divisor: u16) -> (u16, u16) {
        panic!("implement `divmod`")
    }
}

#[generate_trait]
pub impl EvensImpl<T, +Drop<T>, +Copy<T>> of EvensTrait<T> {
    fn evens(self: @Array<T>) -> Array<T> {
        panic!("implement `evens`")
    }
}

pub type Position = (i16, i16);

#[generate_trait]
pub impl PositionImpl of PositionTrait {
    fn manhattan(self: @Position) -> i16 {
        panic!("implement `manhattan`")
    }
}

// The below trait enables calling `abs` on an i16 variable
// to get the absolute value
#[generate_trait]
impl AbsImpl of AbsTrait {
    fn abs(self: @i16) -> u16 {
        let val = if *self < 0 {
            -*self
        } else {
            *self
        };
        val.try_into().unwrap()
    }
}
