pub fn verse(n: u32) -> ByteArray {
    match n {
        0 => "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n",
        1 => "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n",
        2 => "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n",
        _ => format!(
            "{n} bottles of beer on the wall, {n} bottles of beer.\nTake one down and pass it around, {} bottles of beer on the wall.\n",
            n - 1,
        ),
    }
}

pub fn verses(start: u32, take_count: u32) -> ByteArray {
    assert!(0 <= start && start <= 99, "Start verse must be between 0 and 99");
    assert!(0 <= take_count && take_count <= 99, "Count of bottles must be between 0 and 99");
    assert!(take_count <= start, "Cannot take down more than {start} bottles");

    let mut lyrics: ByteArray = "";

    let mut n = start;
    let end = start - take_count;
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
    verses(99, 99)
}
