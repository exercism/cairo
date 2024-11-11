#[derive(Debug, PartialEq, Clone, Drop)]
pub struct WordResult {
    pub word: ByteArray,
    pub count: u64,
}

fn count_words(phrase: ByteArray) -> Span<WordResult> {
    let mut results: Array<WordResult> = ArrayTrait::new();
    let words = split_phrase_into_words(phrase); // Split the phrase into words

    let mut i = 0;
    while i < words.len() {
        let mut found = false; // Flag to check if word is found in results

        // Check if the word already exists in the results
        let mut j = 0;
        while j < results.len() {
            if results[j].word == words[i] { // Compare words
                // We can't mutate results[j] directly, so we need to create a new WordResult
                let updated_result = WordResult {
                    word: results[j].word.clone(),
                    count: *results[j].count + 1, // Increment the count
                };

                // Remove the old result and append the updated one
                results = remove_index_from_array(results, j);
                results.append(updated_result);
                found = true; // Word found, no need to add it
                break; // Exit the inner loop
            }
            j += 1;
        };

        // If the word wasn't found, add it to the results
        if !found {
            let word_and_count = WordResult { word: words[i].clone(), count: 1 };
            results.append(word_and_count);
        }

        i += 1;
    };

    results.span() // Return the results as a span
}

fn remove_index_from_array(arr: Array<WordResult>, index: u32) -> Array<WordResult> {
    let mut new_arr: Array<WordResult> = ArrayTrait::new();

    // Iterate through the original array, skipping the element at `index`
    let mut i = 0;
    while i < arr.len() {
        if i != index {
            new_arr.append(arr[i].clone());
        }
        i += 1;
    };

    new_arr
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

fn is_alphanumeric_or_apostrophe(ch: u8) -> bool {
    // Check if character is alphanumeric or an apostrophe
    ('0' <= ch && ch <= '9') || ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z') || ch == '\''
}

fn to_lowercase(ch: u8) -> u8 {
    // Convert ASCII uppercase letters to lowercase
    if 'A' <= ch && ch <= 'Z' {
        ch + 32 // Convert to lowercase by ASCII offset
    } else {
        ch
    }
}
