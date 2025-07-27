use airport_robot::{Italian, French, say_hello};

#[test]
fn test_say_hello_italian_name_without_spaces() {
    let name = "Flora";
    let language = Italian {};
    let expected = "I can speak Italian: Ciao Flora!";
    let result = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_italian_full_name() {
    let name = "Tomaso Giulio Micheli";
    let language = Italian {};
    let expected = "I can speak Italian: Ciao Tomaso Giulio Micheli!";
    let result = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_french_name_without_spaces() {
    let name = "Jacques";
    let language = French {};
    let expected = "I can speak French: Bonjour Jacques!";
    let result = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_french_full_name() {
    let name = "Manuela Alberto";
    let language = French {};
    let expected = "I can speak French: Bonjour Manuela Alberto!";
    let result = say_hello(name, language);
    assert_eq!(result, expected);
}
