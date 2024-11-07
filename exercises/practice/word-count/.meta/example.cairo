use core::dict::Felt252Dict;


// word_count returns the dictionary of frequency of words based on the input phrase.
pub fn word_count(phrase: ByteArray) -> Felt252Dict<u64> {
    let mut result: Felt252Dict<u64> = Default::default();
    let words = split_phrase_into_words(phrase);

    let mut arr_to_felt: Array<felt252> = ArrayTrait::new();

    let mut i = 0;
    while i < words.len() {
        arr_to_felt.append(bytearray_to_felt252(words[i]));

        let frequency = result.get(*arr_to_felt[i]);
        result.insert(*arr_to_felt[i], frequency + 1);

        i += 1;
    };

    result
}

// split phrase into words
fn split_phrase_into_words(phrase: ByteArray) -> Array<ByteArray> {
    let mut words: Array<ByteArray> = ArrayTrait::new();
    let mut current_word = "";

    let mut i = 0;
    while i < phrase.len() {
        let lower_case = to_lowercase(phrase[i]);
        if is_alphanumeric_or_apostrophe(lower_case) {
            current_word.append_byte(lower_case);
        } else if current_word.len() > 0 {
            current_word = split_apostrophe_from_word(current_word); // all checks happen here
            words.append(current_word);
            current_word = "";
        }

        i += 1;
    };

    // Final word check after the loop
    if current_word.len() > 0 {
        current_word = split_apostrophe_from_word(current_word);
        words.append(current_word);
    };

    words
}

// Trim apostrophes at the start or end or both sides of the current word
fn split_apostrophe_from_word(mut current_word: ByteArray) -> ByteArray {
    let mut i = 0;
    let mut new_word = "";
    while i < current_word.len() {
        if current_word[0] == '\'' && current_word[current_word.len() - 1] == '\'' {
            if i > 0 && current_word[i] == '\'' && i < current_word.len() - 1 {
                new_word.append_byte(get_value(current_word.at(i)));
            } else if current_word[i] != '\'' {
                new_word.append_byte(get_value(current_word.at(i)));
            }
        } else if current_word[0] == '\'' {
            if i != current_word.len() - 1 {
                new_word.append_byte(get_value(current_word.at(i + 1)));
            }
        } else if current_word[current_word.len() - 1] == '\'' {
            if current_word[i] != '\'' {
                new_word.append_byte(get_value(current_word.at(i)));
            }
        } else {
            new_word.append_byte(get_value(current_word.at(i)));
        }

        i += 1;
    };

    new_word
}

// get u8 value from an option
fn get_value(option: Option<u8>) -> u8 {
    match option {
        Option::Some(value) => value, // Extracts and returns the u8 value
        Option::None => {
            // Handle None case appropriately; here we return a default of 0
            0
        }
    }
}

// convert byteArray to felt252
fn bytearray_to_felt252(words: @ByteArray) -> felt252 {
    let mut result: felt252 = 0;

    let mut i = 0;
    while i < words.len() {
        let byte: u8 = words[i];

        result = result * 256 + (byte.into());
        i += 1;
    };

    result
}

fn is_alphanumeric_or_apostrophe(char: u8) -> bool {
    // Check if character is alphanumeric or an apostrophe
    ('0' <= char && char <= '9') || ('a' <= char && char <= 'z') || ('A' <= char && char <= 'Z') || char == '\''
}

fn to_lowercase(char: u8) -> u8 {
    // Convert ASCII uppercase letters to lowercase
    if 'A' <= char && char <= 'Z' {
        char + 32 // Convert to lowercase by ASCII offset
    } else {
        ch
    }
}
