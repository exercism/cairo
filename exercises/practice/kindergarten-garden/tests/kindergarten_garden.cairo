use kindergarten_garden::{plants, Plant, Student};

#[test]
#[ignore]
fn garden_with_single_student() {
    let diagram = "RC
GG";
    let student = Student::Alice;
    let expected = array![Plant::Radishes, Plant::Clover, Plant::Grass, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn different_garden_with_single_student() {
    let diagram = "VC
RC";
    let student = Student::Alice;
    let expected = array![Plant::Violets, Plant::Clover, Plant::Radishes, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn garden_with_two_students() {
    let diagram = "VVCG
VVRC";
    let student = Student::Bob;
    let expected = array![Plant::Clover, Plant::Grass, Plant::Radishes, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn second_students_garden() {
    let diagram = "VVCCGG
VVCCGG";
    let student = Student::Bob;
    let expected = array![Plant::Clover, Plant::Clover, Plant::Clover, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn third_students_garden() {
    let diagram = "VVCCGG
VVCCGG";
    let student = Student::Charlie;
    let expected = array![Plant::Grass, Plant::Grass, Plant::Grass, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_alice_first_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Alice;
    let expected = array![Plant::Violets, Plant::Radishes, Plant::Violets, Plant::Radishes];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_bob_second_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Bob;
    let expected = array![Plant::Clover, Plant::Grass, Plant::Clover, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_charlie() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Charlie;
    let expected = array![Plant::Violets, Plant::Violets, Plant::Clover, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_david() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::David;
    let expected = array![Plant::Radishes, Plant::Violets, Plant::Clover, Plant::Radishes];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_eve() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Eve;
    let expected = array![Plant::Clover, Plant::Grass, Plant::Radishes, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_fred() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Fred;
    let expected = array![Plant::Grass, Plant::Clover, Plant::Violets, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_ginny() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Ginny;
    let expected = array![Plant::Clover, Plant::Grass, Plant::Grass, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_harriet() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Harriet;
    let expected = array![Plant::Violets, Plant::Radishes, Plant::Radishes, Plant::Violets];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_ileana() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Ileana;
    let expected = array![Plant::Grass, Plant::Clover, Plant::Violets, Plant::Clover];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_joseph() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Joseph;
    let expected = array![Plant::Violets, Plant::Clover, Plant::Violets, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_kincaid_second_to_last_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Kincaid;
    let expected = array![Plant::Grass, Plant::Clover, Plant::Clover, Plant::Grass];
    assert_eq!(plants(diagram, student), expected);
}

#[test]
#[ignore]
fn for_larry_last_students_garden() {
    let diagram = "VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV";
    let student = Student::Larry;
    let expected = array![Plant::Grass, Plant::Violets, Plant::Clover, Plant::Violets];
    assert_eq!(plants(diagram, student), expected);
}
