#[derive(Drop)]
pub struct Item {
    pub weight: u32,
    pub value: u32,
}

pub fn maximum_value(maximum_weight: u32, items: Span<Item>) -> u32 {
    panic!("implement `maximum_value`")
}
