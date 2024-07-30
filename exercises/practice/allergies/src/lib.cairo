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
        // construct a new Allergies struct
        panic!("implement `new`")
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        // determine whether the person is allergic to '{allergen}'
        panic!("implement `is_allergic_to`")
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        // return a list of allergies based on the person's allergy score
        panic!("implement `allergies`")
    }
}
