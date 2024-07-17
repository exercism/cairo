#[derive(Drop, Debug)]
struct Set {
    values: Array<ByteArray>
}

#[generate_trait]
impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        Set { values }
    }
}

impl SetEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        let len = lhs.values.len();
        if len != rhs.values.len() {
            return false;
        }
        let mut i = 0;
        loop {
            if i == len {
                break true;
            }
            let l_item = lhs.values.at(i);
            let mut j = 0;
            while j != len {
                if IgnoreCase::eq(l_item, rhs.values.at(j)) {
                    break;
                }
                j += 1;
            };
            if j == len {
                break false;
            }
            i += 1;
        }
    }

    fn ne(lhs: @Set, rhs: @Set) -> bool {
        !(lhs == rhs)
    }
}

fn anagrams_for(word: @ByteArray, inputs: @Set) -> Set {
    let mut word_sorted = @sort_ignore_case(word);
    let mut anagrams = Set { values: array![] };
    let mut i = inputs.values.len();

    while i != 0 {
        i -= 1;
        let candidate = inputs.values[i];

        let is_anagram = word.len() == candidate.len()
            && IgnoreCase::ne(word, candidate)
            && IgnoreCase::eq(word_sorted, @sort_ignore_case(candidate));

        if is_anagram {
            anagrams.values.append(format!("{candidate}"));
        }
    };

    anagrams
}

impl IgnoreCase of PartialEq<ByteArray> {
    fn eq(lhs: @ByteArray, rhs: @ByteArray) -> bool {
        let len = lhs.len();
        if len != rhs.len() {
            return false;
        }
        let mut i = 0;
        loop {
            if i == len {
                break true;
            }
            if lowercase(@lhs[i]) != lowercase(@rhs[i]) {
                break false;
            }
            i += 1;
        }
    }

    fn ne(lhs: @ByteArray, rhs: @ByteArray) -> bool {
        !IgnoreCase::eq(lhs, rhs)
    }
}

fn sort_ignore_case(word: @ByteArray) -> ByteArray {
    // count the number each of the alphabet ASCII characters appears
    let mut ascii_chars: Felt252Dict<u8> = Default::default();
    let mut i = word.len();
    while i != 0 {
        i -= 1;
        let char: felt252 = word[i].into();
        ascii_chars.insert(char, ascii_chars.get(char) + 1);
    };

    let mut sorted_word: ByteArray = "";

    // append each appearing alphabet ASCII character
    let mut alphabet_char: u8 = 65; // char 'A'
    while alphabet_char <= 90 { // char 'Z'
        // process uppercase char
        let mut count = ascii_chars.get(alphabet_char.into());
        while count != 0 {
            sorted_word.append_byte(alphabet_char);
            count -= 1;
        };
        // process lowercase char
        let lowercase_char = alphabet_char + 32;
        let mut count = ascii_chars.get(lowercase_char.into());
        while count != 0 {
            sorted_word.append_byte(lowercase_char);
            count -= 1;
        };

        alphabet_char += 1;
    };

    sorted_word
}

fn lowercase(char: @u8) -> u8 {
    if *char < 97 {
        *char + 32
    } else {
        *char
    }
}

#[cfg(test)]
mod tests;
