use core::num::traits::Pow;

#[derive(Drop)]
struct Allergies {
    score: u32,
}

#[derive(Drop, Copy, Debug, PartialEq)]
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

const ALLERGENS: [Allergen; 8] = [
    Allergen::Eggs, Allergen::Peanuts, Allergen::Shellfish, Allergen::Strawberries,
    Allergen::Tomatoes, Allergen::Chocolate, Allergen::Pollen, Allergen::Cats,
];

#[generate_trait]
pub impl AllergiesImpl of AllergiesTrait {
    fn new(score: u32) -> Allergies {
        Allergies { score }
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        let allergens = ALLERGENS.span();
        let mut found = false;
        let mut index = 0;
        while let Option::Some(next_allergen) = allergens.get(index) {
            if next_allergen.unbox() == allergen {
                found = true;
                break;
            }
            index += 1;
        };
        found && (*self.score & 2_u32.pow(index)) != 0
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        let mut result: Array<Allergen> = array![];
        let allergens = ALLERGENS.span();
        for allergen in allergens {
            if self.is_allergic_to(allergen) {
                result.append(*allergen);
            }
        };
        result
    }
}
