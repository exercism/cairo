use acronym::abbreviate;

#[test]
fn basic() {
    let phrase = "Portable Network Graphics";
    assert_eq!("PNG", abbreviate(phrase));
}

#[test]
#[ignore]
fn lowercase_words() {
    let phrase = "Ruby on Rails";
    assert_eq!("ROR", abbreviate(phrase));
}

#[test]
#[ignore]
fn punctuation() {
    let phrase = "First In, First Out";
    assert_eq!("FIFO", abbreviate(phrase));
}

#[test]
#[ignore]
fn all_caps_word() {
    let phrase = "GNU Image Manipulation Program";
    assert_eq!("GIMP", abbreviate(phrase));
}

#[test]
#[ignore]
fn punctuation_without_whitespace() {
    let phrase = "Complementary metal-oxide semiconductor";
    assert_eq!("CMOS", abbreviate(phrase));
}

#[test]
#[ignore]
fn very_long_abbreviation() {
    let phrase = "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me";
    assert_eq!("ROTFLSHTMDCOALM", abbreviate(phrase));
}

#[test]
#[ignore]
fn consecutive_delimiters() {
    let phrase = "Something - I made up from thin air";
    assert_eq!("SIMUFTA", abbreviate(phrase));
}

#[test]
#[ignore]
fn apostrophes() {
    let phrase = "Halley's Comet";
    assert_eq!("HC", abbreviate(phrase));
}

#[test]
#[ignore]
fn underscore_emphasis() {
    let phrase = "The Road _Not_ Taken";
    assert_eq!("TRNT", abbreviate(phrase));
}
