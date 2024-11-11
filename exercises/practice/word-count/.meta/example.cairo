#[derive(Debug, PartialEq, Clone, Drop)]
pub struct WordResult {
    pub word: ByteArray,
    pub count: u64,
}

fn count_words(phrase: ByteArray) -> Span<WordResult> {
    let mut results: Array<WordResult> = ArrayTrait::new();
    let words = split_phrase_into_words(phrase);

    let mut i = 0;
    while i < words.len() {
        let mut found = false;

        let mut j = 0;
        while j < results.len() {
            if results[j].word == words[i] {
                let updated_result = WordResult {
                    word: results[j].word.clone(), count: *results[j].count + 1,
                };

                results = remove_index_from_array(results, j);
                results.append(updated_result);
                found = true;
                break;
            }
            j += 1;
        };

        if !found {
            let word_and_count = WordResult { word: words[i].clone(), count: 1 };
            results.append(word_and_count);
        }

        i += 1;
    };

    results.span()
}

fn remove_index_from_array(arr: Array<WordResult>, index: u32) -> Array<WordResult> {
    let mut new_arr: Array<WordResult> = ArrayTrait::new();

    let mut i = 0;
    while i < arr.len() {
        if i != index {
            new_arr.append(arr[i].clone());
        }
        i += 1;
    };

    new_arr
}

fn split_phrase_into_words(phrase: ByteArray) -> Array<ByteArray> {
    let mut words: Array<ByteArray> = ArrayTrait::new();
    let mut current_word = "";

    let mut i = 0;
    while i < phrase.len() {
        let lower_case = to_lowercase(phrase[i]);
        if is_alphanumeric_or_apostrophe(lower_case) {
            current_word.append_byte(lower_case);
        } else if current_word.len() > 0 {
            current_word = split_apostrophe_from_word(current_word);
            words.append(current_word);
            current_word = "";
        }

        i += 1;
    };

    if current_word.len() > 0 {
        current_word = split_apostrophe_from_word(current_word);
        words.append(current_word);
    };

    words
}

fn split_apostrophe_from_word(mut current_word: ByteArray) -> ByteArray {
    let mut i = 0;
    let mut new_word = "";
    while i < current_word.len() {
        if current_word[0] == '\'' && current_word[current_word.len() - 1] == '\'' {
            if i > 0 && current_word[i] == '\'' && i < current_word.len() - 1 {
                new_word.append_byte(current_word.at(i).unwrap_or(0));
            } else if current_word[i] != '\'' {
                new_word.append_byte(current_word.at(i).unwrap_or(0));
            }
        } else if current_word[0] == '\'' {
            if i != current_word.len() - 1 {
                new_word.append_byte(current_word.at(i + 1).unwrap_or(0));
            }
        } else if current_word[current_word.len() - 1] == '\'' {
            if current_word[i] != '\'' {
                new_word.append_byte(current_word.at(i).unwrap_or(0));
            }
        } else {
            new_word.append_byte(current_word.at(i).unwrap_or(0));
        }

        i += 1;
    };

    new_word
}

fn is_alphanumeric_or_apostrophe(ch: u8) -> bool {
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
