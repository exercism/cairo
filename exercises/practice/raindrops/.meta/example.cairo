pub fn convert(x: u64) -> ByteArray {
    let mut result = "";

    if x % 3 == 0 {
        result += "Pling";
    }

    if x % 5 == 0 {
        result += "Plang";
    }

    if x % 7 == 0 {
        result += "Plong";
    }

    if result == "" {
        result = format!("{x}");
    }

    return result;
}
