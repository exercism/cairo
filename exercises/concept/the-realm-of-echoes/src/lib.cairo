use core::fmt::{Debug, Display, Formatter, Error};

pub fn format_magical_chant(chant1: ByteArray, chant2: ByteArray, chant3: ByteArray) -> ByteArray {
    panic!("implement 'format_magical_chant'")
}

#[derive(Drop)]
pub struct EchoStone {
    pub power: u32,
    pub duration: u32,
}

impl EchoStoneDisplay of Display<EchoStone> {
    fn fmt(self: @EchoStone, ref f: Formatter) -> Result<(), Error> {
        panic!("implement 'Display::<EchoStone>::fmt'")
    }
}

impl EchoStoneDebug of Debug<EchoStone> {
    fn fmt(self: @EchoStone, ref f: Formatter) -> Result<(), Error> {
        panic!("implement 'Debug::<EchoStone>::fmt'")
    }
}
