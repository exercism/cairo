use kindergarten_garden::plants;

#[test]
fn garden_with_single_student() {
    let diagram = "RC
GG";
    let student = "Alice";
    let expected = array!["radishes", "clover", "grass", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn different_garden_with_single_student() {
    let diagram = "VC
RC";
    let student = "Alice";
    let expected = array!["violets", "clover", "radishes", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn garden_with_two_students() {
    let diagram = "VVCG
VVRC";
    let student = "Bob";
    let expected = array!["clover", "grass", "radishes", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn second_students_garden() {
    let diagram = "VVCCGG
VVCCGG";
    let student = "Bob";
    let expected = array!["clover", "clover", "clover", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn third_students_garden() {
    let diagram = "VVCCGG
VVCCGG";
    let student = "Charlie";
    let expected = array!["grass", "grass", "grass", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_alice_first_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Alice";
    let expected = array!["violets", "radishes", "violets", "radishes"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_bob_second_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Bob";
    let expected = array!["clover", "grass", "clover", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_charlie() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Charlie";
    let expected = array!["violets", "violets", "clover", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_david() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "David";
    let expected = array!["radishes", "violets", "clover", "radishes"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_eve() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Eve";
    let expected = array!["clover", "grass", "radishes", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_fred() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Fred";
    let expected = array!["grass", "clover", "violets", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_ginny() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Ginny";
    let expected = array!["clover", "grass", "grass", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_harriet() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Harriet";
    let expected = array!["violets", "radishes", "radishes", "violets"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_ileana() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Ileana";
    let expected = array!["grass", "clover", "violets", "clover"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_joseph() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Joseph";
    let expected = array!["violets", "clover", "violets", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_kincaid_second_to_last_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Kincaid";
    let expected = array!["grass", "clover", "clover", "grass"];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_larry_last_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = "Larry";
    let expected = array!["grass", "violets", "clover", "violets"];
    assert_eq!(plants(diagram, student), expected);
}
