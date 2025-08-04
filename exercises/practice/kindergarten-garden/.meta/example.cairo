#[derive(Drop, Debug, PartialEq)]
pub enum Plant {
    Radishes,
    Clover,
    Grass,
    Violets,
}

#[derive(Drop)]
pub enum Student {
    Alice,
    Bob,
    Charlie,
    David,
    Eve,
    Fred,
    Ginny,
    Harriet,
    Ileana,
    Joseph,
    Kincaid,
    Larry,
}

/// Function to determine the index of a student in the list
fn get_student_index(student: Student) -> usize {
    match student {
        Student::Alice => 0,
        Student::Bob => 1,
        Student::Charlie => 2,
        Student::David => 3,
        Student::Eve => 4,
        Student::Fred => 5,
        Student::Ginny => 6,
        Student::Harriet => 7,
        Student::Ileana => 8,
        Student::Joseph => 9,
        Student::Kincaid => 10,
        Student::Larry => 11,
    }
}

/// Get string slice
fn lines(diagram: @ByteArray) -> [ByteArray; 2] {
    let mut line1 = "";
    let mut line2 = "";

    let mut i = 0;
    // everything before the newline char is line 1
    while diagram[i] != '\n' {
        line1.append_byte(diagram[i]);
        i += 1;
    }
    // `i` is at the newline char index, so everything after it is line 2
    for i in (i + 1)..diagram.len() {
        line2.append_byte(diagram[i]);
    };

    [line1, line2]
}

/// Mapping plant characters to plant names
fn plant_from_char(c: u8) -> Plant {
    if c == 'R' {
        Plant::Radishes
    } else if c == 'C' {
        Plant::Clover
    } else if c == 'G' {
        Plant::Grass
    } else if c == 'V' {
        Plant::Violets
    } else {
        panic!("No such plant")
    }
}

/// Function to retrieve the plants for a given student based on the diagram
pub fn plants(diagram: ByteArray, student: Student) -> Array<Plant> {
    let index = get_student_index(student);

    let [line1, line2] = lines(@diagram);

    // Retrieve the plants for the student based on the index
    let start = index * 2;
    let plant1 = plant_from_char(line1[start]);
    let plant2 = plant_from_char(line1[start + 1]);
    let plant3 = plant_from_char(line2[start]);
    let plant4 = plant_from_char(line2[start + 1]);

    array![plant1, plant2, plant3, plant4]
}
