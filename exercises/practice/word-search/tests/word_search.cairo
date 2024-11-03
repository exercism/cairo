use word_search::{search, SearchResult};

#[test]
fn Should_accept_an_initial_game_grid_anda_target_search_word() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre"
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 0, 'Expected to find null');
}

#[test]
#[ignore]
fn Should_locate_one_word_written_left_to_right() {
    #[cairofmt::skip]
    let grid = array![
        "clojurermt"
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 1, end_col: 7, end_row: 1, }
    );
}

#[test]
#[ignore]
fn Should_locate_the_same_word_written_left_to_right_in_a_different_position() {
    #[cairofmt::skip]
    let grid = array![
        "mtclojurer"
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 3, start_row: 1, end_col: 9, end_row: 1, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_different_left_to_right_word() {
    #[cairofmt::skip]
    let grid = array![
        "coffeelplx"
    ];

    let wordsToSearchFor = array!["coffee"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "coffee", start_col: 1, start_row: 1, end_col: 6, end_row: 1, }
    );
}

#[test]
#[ignore]
fn Should_locate_that_different_left_to_right_word_in_a_different_position() {
    #[cairofmt::skip]
    let grid = array![
        "xcoffeezlp"
    ];

    let wordsToSearchFor = array!["coffee"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "coffee", start_col: 2, start_row: 1, end_col: 7, end_row: 1, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_left_to_right_word_in_a_two_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "jefblpepre",
        "tclojurerm"
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 2, start_row: 2, end_col: 8, end_row: 2, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_left_to_right_word_in_a_three_line_grid() {
    #[cairofmt::skip]
    let grid = array![
        "camdcimgtc",
        "jefblpepre",
        "clojurermt"
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 3, end_col: 7, end_row: 3, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_left_to_right_word_in_a_ten_line_grid() {
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
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );
}

#[test]
#[ignore]
fn Should_locate_that_left_to_right_word_in_a_different_position_in_a_ten_line_grid() {
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
    ];

    let wordsToSearchFor = array!["clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_different_left_to_right_word_in_a_ten_line_grid() {
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
    ];

    let wordsToSearchFor = array!["fortran"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 2 words');

    assert_eq!(
        results[0],
        @SearchResult { word: "fortran", start_col: 1, start_row: 7, end_col: 7, end_row: 7, }
    );
}

#[test]
#[ignore]
fn Should_locate_multiple_words() {
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
    ];

    let wordsToSearchFor = array!["fortran", "clojure"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 2, 'Expected to find 2 words');

    assert_eq!(
        results[0],
        @SearchResult { word: "fortran", start_col: 1, start_row: 7, end_col: 7, end_row: 7, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );
}

#[test]
#[ignore]
fn Should_locate_a_single_word_written_right_to_left() {
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
    ];

    let wordsToSearchFor = array!["elixir"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 1, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );
}

#[test]
#[ignore]
fn Should_locate_multiple_words_written_in_different_horizontal_directions() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 2, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );
}

#[test]
#[ignore]
fn Should_locate_words_written_top_to_bottom() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir", "ecmascript"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 3, 'Expected to find 3 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
}


#[test]
#[ignore]
fn Should_locate_words_written_bottom_to_top() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir", "ecmascript", "rust"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 4, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
}

#[test]
#[ignore]
fn Should_locate_words_written_top_left_to_bottom_right() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir", "ecmascript", "rust", "java"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 5, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
    assert_eq!(
        results[4],
        @SearchResult { word: "java", start_col: 1, start_row: 1, end_col: 4, end_row: 4, }
    );
}

#[test]
#[ignore]
fn Should_locate_words_written_bottom_right_to_top_left() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir", "ecmascript", "rust", "java", "lua",];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 6, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
    assert_eq!(
        results[4],
        @SearchResult { word: "java", start_col: 1, start_row: 1, end_col: 4, end_row: 4, }
    );

    assert_eq!(
        results[5],
        @SearchResult { word: "lua", start_col: 8, start_row: 9, end_col: 6, end_row: 7, }
    );
}


#[test]
#[ignore]
fn Should_locate_words_written_bottom_left_to_top_right() {
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
    ];

    let wordsToSearchFor = array!["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 7, 'Expected to find 2 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
    assert_eq!(
        results[4],
        @SearchResult { word: "java", start_col: 1, start_row: 1, end_col: 4, end_row: 4, }
    );

    assert_eq!(
        results[5],
        @SearchResult { word: "lua", start_col: 8, start_row: 9, end_col: 6, end_row: 7, }
    );
    assert_eq!(
        results[6],
        @SearchResult { word: "lisp", start_col: 3, start_row: 6, end_col: 6, end_row: 3, }
    );
}

#[test]
#[ignore]
fn Should_locate_words_written_top_right_to_bottom_left() {
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
    ];

    let wordsToSearchFor = array![
        "clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby"
    ];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 8, 'Expected to find 2 words');

    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );

    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
    assert_eq!(
        results[4],
        @SearchResult { word: "java", start_col: 1, start_row: 1, end_col: 4, end_row: 4, }
    );

    assert_eq!(
        results[5],
        @SearchResult { word: "lua", start_col: 8, start_row: 9, end_col: 6, end_row: 7, }
    );
    assert_eq!(
        results[6],
        @SearchResult { word: "lisp", start_col: 3, start_row: 6, end_col: 6, end_row: 3, }
    );
    assert_eq!(
        results[7],
        @SearchResult { word: "ruby", start_col: 8, start_row: 6, end_col: 5, end_row: 9, }
    );
}
#[test]
#[ignore]
fn Should_fail_to_locate_a_word_that_is_not_in_the_puzzle() {
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
    ];

    let wordsToSearchFor = array![
        "clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby", "haskell"
    ];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 8, 'Expected to find 7 words');
    assert_eq!(
        results[0],
        @SearchResult { word: "clojure", start_col: 1, start_row: 10, end_col: 7, end_row: 10, }
    );
    assert_eq!(
        results[1],
        @SearchResult { word: "elixir", start_col: 6, start_row: 5, end_col: 1, end_row: 5, }
    );

    assert_eq!(
        results[2],
        @SearchResult { word: "ecmascript", start_col: 10, start_row: 1, end_col: 10, end_row: 10, }
    );
    assert_eq!(
        results[3],
        @SearchResult { word: "rust", start_col: 9, start_row: 5, end_col: 9, end_row: 2, }
    );
    assert_eq!(
        results[4],
        @SearchResult { word: "java", start_col: 1, start_row: 1, end_col: 4, end_row: 4, }
    );

    assert_eq!(
        results[5],
        @SearchResult { word: "lua", start_col: 8, start_row: 9, end_col: 6, end_row: 7, }
    );
    assert_eq!(
        results[6],
        @SearchResult { word: "lisp", start_col: 3, start_row: 6, end_col: 6, end_row: 3, }
    );
    assert_eq!(
        results[7],
        @SearchResult { word: "ruby", start_col: 8, start_row: 6, end_col: 5, end_row: 9, }
    );
}
#[test]
#[ignore]
fn Should_fail_to_locate_words_that_are_not_on_horizontal_vertical_or_diagonal_lines() {
    #[cairofmt::skip]
    let grid = array![
        "abc",
        "def"
    ];

    let wordsToSearchFor = array!["aef", "ced", "abf", "cbd"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 0, 'Expected to find null');
}
#[test]
#[ignore]
fn Should_not_concatenate_different_lines_to_find_a_horizontal_word() {
    #[cairofmt::skip]
    let grid = array![
        "abceli",
        "xirdfg"
    ];

    let wordsToSearchFor = array!["elixir"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 0, 'Expected to find null');
}

#[test]
#[ignore]
fn Should_not_wrap_around_horizontally_to_find_a_word() {
    #[cairofmt::skip]
    let grid = array![
        "silabcdefp"
    ];

    let wordsToSearchFor = array!["lisp"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 0, 'Expected to find null');
}


#[test]
#[ignore]
fn Should_not_wrap_around_vertically_to_find_a_word() {
    #[cairofmt::skip]
    let grid = array![
        "s",
        "u", 
        "r",
        "a",
        "b",
        "c",
        "t"
    ];

    let wordsToSearchFor = array!["rust"];

    let results = search(grid, wordsToSearchFor);

    assert(results.len() == 0, 'Expected to find null');
}
