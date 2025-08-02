use airport_robot::{Italian, French, say_hello};

#[test]
fn test_say_hello_italian_name_without_spaces() {
    let name: ByteArray = "Flora";
    let language = Italian {};
    let expected: ByteArray = "I can speak Italian: Ciao Flora!";
    let result: ByteArray = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_italian_full_name() {
    let name: ByteArray = "Tomaso Giulio Micheli";
    let language = Italian {};
    let expected: ByteArray = "I can speak Italian: Ciao Tomaso Giulio Micheli!";
    let result: ByteArray = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_french_name_without_spaces() {
    let name: ByteArray = "Jacques";
    let language = French {};
    let expected: ByteArray = "I can speak French: Bonjour Jacques!";
    let result: ByteArray = say_hello(name, language);
    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn test_say_hello_french_full_name() {
    let name: ByteArray = "Manuela Alberto";
    let language = French {};
    let expected: ByteArray = "I can speak French: Bonjour Manuela Alberto!";
    let result: ByteArray = say_hello(name, language);
    assert_eq!(result, expected);
}
