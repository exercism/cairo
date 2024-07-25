pub type Domino = (u8, u8);

pub fn chain(dominoes: @Array<Domino>) -> Option<Array<Domino>> {
    panic!(
        "implement `chain`: from the given dominoes '{dominoes:?}' constructs a proper dominoes chain or return Option::None if it is not possible."
    )
}
