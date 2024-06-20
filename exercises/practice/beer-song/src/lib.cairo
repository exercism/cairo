pub fn verse(n: u32) -> ByteArray {
    panic!("emit verse {n}")
}

pub fn verses(start: u32, end: u32) -> ByteArray {
    panic!("sing verses {start} to {end}, inclusive")
}

pub fn song() -> ByteArray {
    panic!("sing the whole song")
}

#[cfg(test)]
mod tests;

