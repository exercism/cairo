#[derive(Drop)]
struct Allergies {}

#[derive(Drop, Debug, PartialEq)]
pub enum Allergen {
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
pub impl AllergiesImpl of AllergiesTrait {
    fn new(score: u32) -> Allergies {
        panic!("Implement `new`: constructs a new Allergies struct")
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        panic!("implement `is_allergic_to`: determines whether the person is allergic to '{allergen:?}'")
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        panic!(
            "implement `allergies`: returns a list of allergies based on the person's allergy score"
        )
    }
}
