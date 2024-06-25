#[derive(Drop, Debug, PartialEq)]
pub struct Roman {}

#[generate_trait]
impl RomanImpl of RomanTrait {
    fn new(num: u32) -> Roman {
        panic!()
    }
}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        panic!()
    }
}

impl RomanIIntoByteArray of Into<Roman, ByteArray> {
    #[must_use]
    fn into(self: Roman) -> ByteArray {
        panic!()
    }
}

#[cfg(test)]
mod tests;
