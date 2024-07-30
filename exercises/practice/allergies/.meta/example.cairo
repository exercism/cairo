#[derive(Drop)]
struct Allergies {
    score: u32,
}

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
        Allergies { score }
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        let allergens = AllergiesImpl::allergens().span();
        let mut index = 0;
        while let Option::Some(next_allergen) = allergens
            .get(index) {
                if next_allergen.unbox() == allergen {
                    break;
                }
                index += 1;
            };
        index != allergens.len() && (*self.score & pow(2, index)) != 0
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        let mut result: Array<Allergen> = array![];
        let mut allergens = AllergiesImpl::allergens();
        while let Option::Some(allergen) = allergens
            .pop_front() {
                if self.is_allergic_to(@allergen) {
                    result.append(allergen);
                }
            };
        result
    }

    fn allergens() -> Array<Allergen> {
        array![
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ]
    }
}

fn pow(base: u32, mut power: u32) -> u32 {
    if base == 0 {
        return base;
    }
    let base: u256 = base.into();
    let mut result = 1_u256;
    while power != 0 {
        result *= base;
        power -= 1;
    };
    result.try_into().expect('too large to fit output type')
}
