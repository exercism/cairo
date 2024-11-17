#[derive(Debug, PartialEq, Clone, Drop)]
pub struct WordResult {
    pub word: ByteArray,
    pub count: u64,
}

pub fn count_words(phrase: ByteArray) -> Span<WordResult> {
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
            if !is_apostrophe(lower_case)
                || (i > 0 && i < phrase.len()
                    - 1 && is_alphanumeric_or_apostrophe(phrase[i - 1]) && is_alphanumeric_or_apostrophe(phrase[i + 1])) {
                current_word.append_byte(lower_case);
            }
        } else if current_word.len() > 0 {
            words.append(current_word.clone());
            current_word = "";
        }

        i += 1;
    };

    if current_word.len() > 0 {
        words.append(current_word);
    }

    words
}

fn is_alphanumeric_or_apostrophe(ch: u8) -> bool {
    ('0' <= ch && ch <= '9') || ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z') || ch == '\''
}

fn is_apostrophe(ch: u8) -> bool {
    ch == '\''
}

fn to_lowercase(ch: u8) -> u8 {
    if 'A' <= ch && ch <= 'Z' {
        ch + 32
    } else {
        ch
    }
}
