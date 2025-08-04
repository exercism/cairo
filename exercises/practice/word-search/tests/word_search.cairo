use word_search::{Position, SearchResult, search};

#[test]
fn should_accept_an_initial_game_grid_and_a_target_search_word() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    assert!(results.is_empty());
}

#[test]
#[ignore]
fn should_locate_one_word_written_left_to_right() {
    #[cairofmt::skip]
    let grid = array![
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);
    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 1 }, end: Position { col: 7, row: 1 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_the_same_word_written_left_to_right_in_a_different_position() {
    #[cairofmt::skip]
    let grid = array![
        "mtclojurer"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 3, row: 1 }, end: Position { col: 9, row: 1 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_different_left_to_right_word() {
    #[cairofmt::skip]
    let grid = array![
        "coffeelplx"
    ].span();

    let words_to_search_for = array!["coffee"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "coffee", start: Position { col: 1, row: 1 }, end: Position { col: 6, row: 1 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_that_different_left_to_right_word_in_a_different_position() {
    #[cairofmt::skip]
    let grid = array![
        "xcoffeezlp"
    ].span();

    let words_to_search_for = array!["coffee"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "coffee", start: Position { col: 2, row: 1 }, end: Position { col: 7, row: 1 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_left_to_right_word_in_a_two_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "tclojurerm"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 2, row: 2 }, end: Position { col: 8, row: 2 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_left_to_right_word_in_a_three_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "camdcimgtc",
        "jefblpepre",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 3 }, end: Position { col: 7, row: 3 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_left_to_right_word_in_a_ten_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_that_left_to_right_word_in_a_different_position_in_a_ten_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "clojurermt",
        "jalaycalmp"
    ]
        .span();

    let words_to_search_for = array!["clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 9 }, end: Position { col: 7, row: 9 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_different_left_to_right_word_in_a_ten_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "fortranftw",
        "alxhpburyi",
        "clojurermt",
        "jalaycalmp"
    ]
        .span();

    let words_to_search_for = array!["fortran"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "fortran", start: Position { col: 1, row: 7 }, end: Position { col: 7, row: 7 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_multiple_words() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "fortranftw",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["fortran", "clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "fortran", start: Position { col: 1, row: 7 }, end: Position { col: 7, row: 7 },
        },
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_a_single_word_written_right_to_left() {
    #[cairofmt::skip]
    let grid = array![
        "rixilelhrs"
    ].span();

    let words_to_search_for = array!["elixir"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 1 }, end: Position { col: 1, row: 1 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_multiple_words_written_in_different_horizontal_directions() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["elixir", "clojure"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_words_written_top_to_bottom() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure", "elixir", "ecmascript"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}


#[test]
#[ignore]
fn should_locate_words_written_bottom_to_top() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure", "elixir", "ecmascript", "rust"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_words_written_top_left_to_bottom_right() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure", "elixir", "ecmascript", "rust", "java"].span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
        SearchResult {
            word: "java", start: Position { col: 1, row: 1 }, end: Position { col: 4, row: 4 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_words_written_bottom_right_to_top_left() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array!["clojure", "elixir", "ecmascript", "rust", "java", "lua"]
        .span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
        SearchResult {
            word: "java", start: Position { col: 1, row: 1 }, end: Position { col: 4, row: 4 },
        },
        SearchResult {
            word: "lua", start: Position { col: 8, row: 9 }, end: Position { col: 6, row: 7 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}


#[test]
#[ignore]
fn should_locate_words_written_bottom_left_to_top_right() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array![
        "clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp",
    ]
        .span();

    let results = search(grid, words_to_search_for);
    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
        SearchResult {
            word: "java", start: Position { col: 1, row: 1 }, end: Position { col: 4, row: 4 },
        },
        SearchResult {
            word: "lua", start: Position { col: 8, row: 9 }, end: Position { col: 6, row: 7 },
        },
        SearchResult {
            word: "lisp", start: Position { col: 3, row: 6 }, end: Position { col: 6, row: 3 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}

#[test]
#[ignore]
fn should_locate_words_written_top_right_to_bottom_left() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array![
        "clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby",
    ]
        .span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
        SearchResult {
            word: "java", start: Position { col: 1, row: 1 }, end: Position { col: 4, row: 4 },
        },
        SearchResult {
            word: "lua", start: Position { col: 8, row: 9 }, end: Position { col: 6, row: 7 },
        },
        SearchResult {
            word: "lisp", start: Position { col: 3, row: 6 }, end: Position { col: 6, row: 3 },
        },
        SearchResult {
            word: "ruby", start: Position { col: 8, row: 6 }, end: Position { col: 5, row: 9 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}
#[test]
#[ignore]
fn should_fail_to_locate_a_word_that_is_not_in_the_puzzle() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    ].span();

    let words_to_search_for = array![
        "clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby", "haskell",
    ]
        .span();

    let results = search(grid, words_to_search_for);

    let expected = array![
        SearchResult {
            word: "clojure", start: Position { col: 1, row: 10 }, end: Position { col: 7, row: 10 },
        },
        SearchResult {
            word: "elixir", start: Position { col: 6, row: 5 }, end: Position { col: 1, row: 5 },
        },
        SearchResult {
            word: "ecmascript",
            start: Position { col: 10, row: 1 },
            end: Position { col: 10, row: 10 },
        },
        SearchResult {
            word: "rust", start: Position { col: 9, row: 5 }, end: Position { col: 9, row: 2 },
        },
        SearchResult {
            word: "java", start: Position { col: 1, row: 1 }, end: Position { col: 4, row: 4 },
        },
        SearchResult {
            word: "lua", start: Position { col: 8, row: 9 }, end: Position { col: 6, row: 7 },
        },
        SearchResult {
            word: "lisp", start: Position { col: 3, row: 6 }, end: Position { col: 6, row: 3 },
        },
        SearchResult {
            word: "ruby", start: Position { col: 8, row: 6 }, end: Position { col: 5, row: 9 },
        },
    ]
        .span();

    assert_eq!(results, expected);
}
#[test]
#[ignore]
fn should_fail_to_locate_words_that_are_not_on_horizontal_vertical_or_diagonal_lines() {
    #[cairofmt::skip]
    let grid = array![
        "abc",
        "def"
    ].span();

    let words_to_search_for = array!["aef", "ced", "abf", "cbd"].span();

    let results = search(grid, words_to_search_for);

    assert!(results.is_empty());
}
#[test]
#[ignore]
fn should_not_concatenate_different_lines_to_find_a_horizontal_word() {
    #[cairofmt::skip]
    let grid = array![
        "abceli",
        "xirdfg"
    ].span();

    let words_to_search_for = array!["elixir"].span();

    let results = search(grid, words_to_search_for);

    assert!(results.is_empty());
}

#[test]
#[ignore]
fn should_not_wrap_around_horizontally_to_find_a_word() {
    #[cairofmt::skip]
    let grid = array![
        "silabcdefp"
    ].span();

    let words_to_search_for = array!["lisp"].span();

    let results = search(grid, words_to_search_for);

    assert!(results.is_empty());
}


#[test]
#[ignore]
fn should_not_wrap_around_vertically_to_find_a_word() {
    #[cairofmt::skip]
    let grid = array![
        "s",
        "u", 
        "r",
        "a",
        "b",
        "c",
        "t"
    ].span();

    let words_to_search_for = array!["rust"].span();

    let results = search(grid, words_to_search_for);

    assert!(results.is_empty());
}
