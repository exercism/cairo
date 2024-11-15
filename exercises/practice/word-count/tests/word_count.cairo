use word_count::{count_words, WordResult};

#[test]
fn count_one_word() {
    let input = "word";
    let mut output = count_words(input);

    let expected = array![WordResult { word: "word", count: 1 }].span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn count_one_of_each_word() {
    let input = "one of each";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "of", count: 1 },
        WordResult { word: "each", count: 1 },
        WordResult { word: "one", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn multiple_occurrences_of_a_word() {
    let input = "one fish two fish red fish blue fish";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "one", count: 1 },
        WordResult { word: "two", count: 1 },
        WordResult { word: "red", count: 1 },
        WordResult { word: "blue", count: 1 },
        WordResult { word: "fish", count: 4 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn handles_cramped_lists() {
    let input = "one,two,three";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "one", count: 1 },
        WordResult { word: "two", count: 1 },
        WordResult { word: "three", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn handles_expanded_lists() {
    let input = "one,\ntwo,\nthree";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "one", count: 1 },
        WordResult { word: "two", count: 1 },
        WordResult { word: "three", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn ignore_punctuation() {
    let input = "car: carpet as java: javascript!!&@$%^&";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "car", count: 1 },
        WordResult { word: "carpet", count: 1 },
        WordResult { word: "as", count: 1 },
        WordResult { word: "java", count: 1 },
        WordResult { word: "javascript", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn include_numbers() {
    let input = "testing, 1, 2 testing";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "testing", count: 2 },
        WordResult { word: "1", count: 1 },
        WordResult { word: "2", count: 1 },
    ]
        .span();

    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn normalize_case() {
    let input = "go Go GO Stop stop";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "go", count: 3 }, WordResult { word: "stop", count: 2 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn with_apostrophes() {
    let input = "'First: don't laugh. Then: don't cry. You're getting it.'";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "first", count: 1 },
        WordResult { word: "laugh", count: 1 },
        WordResult { word: "then", count: 1 },
        WordResult { word: "don't", count: 2 },
        WordResult { word: "cry", count: 1 },
        WordResult { word: "you're", count: 1 },
        WordResult { word: "getting", count: 1 },
        WordResult { word: "it", count: 1 },
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn with_quotations() {
    let input = "Joe can't tell between 'large' and large.";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "joe", count: 1 },
        WordResult { word: "can't", count: 1 },
        WordResult { word: "tell", count: 1 },
        WordResult { word: "between", count: 1 },
        WordResult { word: "and", count: 1 },
        WordResult { word: "large", count: 2 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn substrings_from_the_beginning() {
    let input = "Joe can't tell between app, apple and a.";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "joe", count: 1 },
        WordResult { word: "can't", count: 1 },
        WordResult { word: "tell", count: 1 },
        WordResult { word: "between", count: 1 },
        WordResult { word: "app", count: 1 },
        WordResult { word: "apple", count: 1 },
        WordResult { word: "and", count: 1 },
        WordResult { word: "a", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn multiple_spaces_not_detected_as_a_word() {
    let input = " multiple   whitespaces";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "multiple", count: 1 }, WordResult { word: "whitespaces", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn alternating_word_separators_not_detected_as_a_word() {
    let input = ",\n,one,\n ,two \n 'three'";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "one", count: 1 },
        WordResult { word: "two", count: 1 },
        WordResult { word: "three", count: 1 }
    ]
        .span();
    assert_unordered(output, expected);
}

#[test]
#[ignore]
fn quotation_for_word_with_apostrophe() {
    let input = "can, can't, 'can't'";
    let mut output = count_words(input);

    let expected = array![
        WordResult { word: "can", count: 1 }, WordResult { word: "can't", count: 2 }
    ]
        .span();
    assert_unordered(output, expected);
}


// helper function.
fn assert_unordered(span1: Span<WordResult>, span2: Span<WordResult>) {
    for item in span1 {
        for other_item in span2 {
            if item.word == other_item.word {
                assert_eq!(item.word, other_item.word);
                assert_eq!(item.count, other_item.count);
            }
        }
    }
}
