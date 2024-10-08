#[derive(Drop, Debug, PartialEq)]
pub enum Plant {
    Radishes,
    Clover,
    Grass,
    Violets
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

pub fn plants(diagram: ByteArray, student: Student) -> Array<Plant> {
    panic!("implement `plants`")
}
