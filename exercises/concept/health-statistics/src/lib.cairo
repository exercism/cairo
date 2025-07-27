#[derive(Drop)]
pub struct User {
    name: ByteArray,
    age: u32,
    weight: u32,
}

pub trait UserTrait {
    fn new(name: ByteArray, age: u32, weight: u32) -> User;
    fn name(self: @User) -> @ByteArray;
    fn age(self: @User) -> u32;
    fn weight(self: @User) -> u32;
    fn set_age(ref self: User, new_age: u32);
    fn set_weight(ref self: User, new_weight: u32);
}

impl UserImpl of UserTrait {
    fn new(name: ByteArray, age: u32, weight: u32) -> User {
        panic!("implement `new`")
    }

    fn name(self: @User) -> @ByteArray {
        panic!("implement `name`")
    }

    fn age(self: @User) -> u32 {
        panic!("implement `age`")
    }

    fn weight(self: @User) -> u32 {
        panic!("implement `weight`")
    }

    fn set_age(ref self: User, new_age: u32) {
        panic!("implement `set_age`")
    }

    fn set_weight(ref self: User, new_weight: u32) {
        panic!("implement `set_weight`")
    }
}
