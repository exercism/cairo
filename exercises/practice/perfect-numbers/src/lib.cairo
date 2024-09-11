#[derive(Debug, Drop, PartialEq)]
pub enum Classification {
    Deficient,
    Perfect,
    Abundant,
}

pub fn classify(number: u64) -> Classification {
    panic!("implement `classify`")
}
