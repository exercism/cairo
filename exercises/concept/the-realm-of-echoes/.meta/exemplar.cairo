use core::fmt::{Debug, Display, Formatter, Error};

pub fn format_magical_chant(chant1: ByteArray, chant2: ByteArray, chant3: ByteArray) -> ByteArray {
    format!("{chant1}-{chant2}-{chant3}")
}

#[derive(Drop)]
pub struct EchoStone {
    pub power: u32,
    pub duration: u32,
}

impl EchoStoneDisplay of Display<EchoStone> {
    fn fmt(self: @EchoStone, ref f: Formatter) -> Result<(), Error> {
        write!(f, "EchoStone [power: {}, duration: {}]", *self.power, *self.duration)
    }
}

impl EchoStoneDebug of Debug<EchoStone> {
    fn fmt(self: @EchoStone, ref f: Formatter) -> Result<(), Error> {
        write!(f, "Debugging EchoStone: {{ power: {}, duration: {} }}", *self.power, *self.duration)
    }
}
