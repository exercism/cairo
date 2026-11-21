pub fn transpose(input: Array<ByteArray>) -> Array<ByteArray> {
    let mut output: Array<ByteArray> = ArrayTrait::new();

    let mut max_length = 0;
    for line in input.clone() {
        if line.len() > max_length {
            max_length = line.len();
        }
    };

    let mut i = 0;
    loop {
        let mut temp: ByteArray = "";
        for line in input
            .clone() {
                while i < max_length {
                    match line.at(i) {
                        Option::Some(char) => { temp.append_byte(char); },
                        Option::None => { temp.append_byte(' '); },
                    }
                    break;
                };
                if temp.len() == input.len() {
                    output.append(temp.clone());
                    i += 1;
                }
                continue;
            };
        if i == max_length {
            break;
        }
    };

    output
}
