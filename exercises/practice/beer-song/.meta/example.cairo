pub fn verse(n: u32) -> ByteArray {
    if n == 0 {
        return "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n";
    } else if n == 1 {
        return "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n";
    } else if n == 2 {
        return "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n";
    } else if n <= 99 {
        return format!(
            "{n} bottles of beer on the wall, {n} bottles of beer.\nTake one down and pass it around, {} bottles of beer on the wall.\n",
            n - 1
        );
    } else {
        panic!()
    }
}

pub fn verses(start: u32, end: u32) -> ByteArray {
    let mut lyrics: ByteArray = "";
    let mut n = start;
    while n >= end {
        lyrics.append(@verse(n));
        if n == end {
            break;
        }
        lyrics.append(@"\n");
        n -= 1;
    };
    lyrics
}

pub fn song() -> ByteArray {
    verses(99, 0)
}

#[cfg(test)]
mod tests;

