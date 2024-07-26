use core::fmt::{Display, Error, Formatter};

#[derive(Drop)]
pub struct Roman {}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        // convert the integer into a Roman number
        panic!("implement `into`")
    }
}

impl RomanDisplay of Display<Roman> {
    fn fmt(self: @Roman, ref f: Formatter) -> Result<(), Error> {
        // define how the Roman number should be converted to a string
        panic!("implement `fmt`")
    }
}
