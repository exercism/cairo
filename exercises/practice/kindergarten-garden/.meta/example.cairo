/// Function to determine the index of a student in the list
fn get_student_index(student: ByteArray) -> Option<usize> {
    let student_names: Array<ByteArray> = array![
        "Alice",
        "Bob",
        "Charlie",
        "David",
        "Eve",
        "Fred",
        "Ginny",
        "Harriet",
        "Ileana",
        "Joseph",
        "Kincaid",
        "Larry",
    ];

    let mut index: Option<usize> = Option::None;
    for i in 0
        ..student_names
            .len() {
                if @student == student_names[i] {
                    index = Option::Some(i);
                    break;
                }
            };

    index
}

/// Get string slice
fn slice(diagram: @ByteArray, from: usize, length: usize) -> ByteArray {
    let mut result = "";

    for i in from..(from + length) {
        result.append_byte(diagram[i]);
    };

    result
}

/// Mapping plant characters to plant names
fn plant_from_char(c: u8) -> ByteArray {
    if c == 'R' {
        "radishes"
    } else if c == 'C' {
        "clover"
    } else if c == 'G' {
        "grass"
    } else if c == 'V' {
        "violets"
    } else {
        panic!("No such plant")
    }
}

/// Function to retrieve the plants for a given student based on the diagram
pub fn plants(diagram: ByteArray, student: ByteArray) -> Array<ByteArray> {
    let index = get_student_index(student).expect('Unexpected student name');

    let start = index * 2;

    // Split the diagram into rows
    let row1 = slice(@diagram, 0, diagram.len() / 2);
    let row2 = slice(@diagram, diagram.len() / 2, diagram.len() / 2);

    // Retrieve the plants for the student based on the index
    let plant1 = plant_from_char(row1[start]);
    let plant2 = plant_from_char(row1[start + 1]);
    let plant3 = plant_from_char(row2[start]);
    let plant4 = plant_from_char(row2[start + 1]);

    // Return an array with the student's plants
    let mut result = array![plant1, plant2, plant3, plant4,];
    result
}
