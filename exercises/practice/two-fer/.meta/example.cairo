pub fn response(name: Option<ByteArray>) -> ByteArray {
    match name {
        Option::Some(n) => format!("One for {n}, one for me."),
        Option::None => "One for you, one for me."
    }
}
