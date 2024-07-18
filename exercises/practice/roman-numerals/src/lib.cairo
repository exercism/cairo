use core::fmt::{Display, Error, Formatter};

#[derive(Drop)]
struct Roman {}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        panic!()
    }
}

impl RomanDisplay of Display<Roman> {
    fn fmt(self: @Roman, ref f: Formatter) -> Result<(), Error> {
        panic!()
    }
}
