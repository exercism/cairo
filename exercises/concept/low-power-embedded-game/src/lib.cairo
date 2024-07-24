#[generate_trait]
pub impl DivmodImpl of DivmodTrait {
    fn divmod(self: @u16, divisor: u16) -> (u16, u16) {
        panic!("implement `fn divmod`")
    }
}

#[generate_trait]
pub impl EvensImpl<T, +Drop<T>, +Copy<T>> of EvensTrait<T> {
    fn evens(self: @Array<T>) -> Array<T> {
        panic!("implement `fn evens`")
    }
}

pub type Position = (i16, i16);

#[generate_trait]
pub impl PositionImpl of PositionTrait {
    fn manhattan(self: @Position) -> i16 {
        panic!("implement `fn manhattan`")
    }
}
