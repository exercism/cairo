#[derive(Drop)]
struct Allergies {}

#[derive(Drop, Debug, PartialEq)]
enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

#[generate_trait]
impl AllergiesImpl of AllergiesTrait {
    fn new(score: u32) -> Allergies {
        panic!("Given the '{score}' score, construct a new Allergies struct.")
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        panic!("Determine if the patient is allergic to the '{allergen:?}' allergen.")
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        panic!(
            "Return the list of allergens contained within the score with which the Allergies struct was made."
        )
    }
}

#[cfg(test)]
mod tests;
