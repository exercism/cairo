#[generate_trait]
impl DivmodImpl of DivmodTrait {
    fn divmod(self: @u16, divisor: u16) -> (u16, u16) {
        panic!("implement `fn divmod`")
    }
}

#[generate_trait]
impl EvensImpl<T, +Drop<T>, +Copy<T>> of EvensTrait<T> {
    fn evens(self: @Array<T>) -> Array<T> {
        panic!("implement `fn evens`")
    }
}

type Position = (i16, i16);

#[generate_trait]
impl PositionImpl of PositionTrait {
    fn manhattan(self: @Position) -> i16 {
        panic!("implement `fn manhattan`")
    }
}

#[generate_trait]
impl AbsImpl of AbsTrait {
    fn abs(self: @i16) -> i16 {
        if *self < 0 {
            *self * -1
        } else {
            *self
        }
    }
}

#[cfg(test)]
mod tests;
