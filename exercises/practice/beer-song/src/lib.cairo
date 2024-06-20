pub fn verse(n: u32) -> ByteArray {
    panic!("emit verse {n}")
}

pub fn verses(start: u32, take_count: u32) -> ByteArray {
    panic!("sing {take_count} verses from {start}")
}

pub fn song() -> ByteArray {
    panic!("sing the whole song")
}

#[cfg(test)]
mod tests;

