use allergies::{Allergen, AllergiesTrait};

fn compare_allergy_vectors(expected: @Array<Allergen>, actual: @Array<Allergen>) {
    if actual.len() != expected.len() {
        panic!(
            "Allergy vectors are of different lengths\n  expected {expected:?}\n  got {actual:?}"
        );
    }

    let mut i = 0;
    while let Option::Some(expected_elem) = expected
        .get(i) {
            let mut contains = false;
            let mut j = 0;
            while let Option::Some(actual_elem) = actual
                .get(j) {
                    if actual_elem.unbox() == expected_elem.unbox() {
                        contains = true;
                        break;
                    }
                    j += 1;
                };
            if !contains {
                panic!("Allergen missing\n  {expected_elem:?} should be in {actual:?}");
            }
            i += 1;
        };
}

#[test]
fn not_allergic_to_anything_eggs() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Eggs))
}

#[test]
fn allergic_only_to_eggs_eggs() {
    let allergies = AllergiesTrait::new(1);
    assert!(allergies.is_allergic_to(@Allergen::Eggs))
}

#[test]
fn allergic_to_eggs_and_something_else_eggs() {
    let allergies = AllergiesTrait::new(3);
    assert!(allergies.is_allergic_to(@Allergen::Eggs))
}

#[test]
fn allergic_to_something_but_not_eggs_eggs() {
    let allergies = AllergiesTrait::new(2);
    assert!(!allergies.is_allergic_to(@Allergen::Eggs))
}

#[test]
fn allergic_to_everything_eggs() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Eggs))
}

#[test]
fn not_allergic_to_anything_peanuts() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Peanuts))
}

#[test]
fn allergic_only_to_peanuts_peanuts() {
    let allergies = AllergiesTrait::new(2);
    assert!(allergies.is_allergic_to(@Allergen::Peanuts))
}

#[test]
fn allergic_to_peanuts_and_something_else_peanuts() {
    let allergies = AllergiesTrait::new(7);
    assert!(allergies.is_allergic_to(@Allergen::Peanuts))
}

#[test]
fn allergic_to_something_but_not_peanuts_peanuts() {
    let allergies = AllergiesTrait::new(5);
    assert!(!allergies.is_allergic_to(@Allergen::Peanuts))
}

#[test]
fn allergic_to_everything_peanuts() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Peanuts))
}

#[test]
fn not_allergic_to_anything_shellfish() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Shellfish))
}

#[test]
fn allergic_only_to_shellfish_shellfish() {
    let allergies = AllergiesTrait::new(4);
    assert!(allergies.is_allergic_to(@Allergen::Shellfish))
}

#[test]
fn allergic_to_shellfish_and_something_else_shellfish() {
    let allergies = AllergiesTrait::new(14);
    assert!(allergies.is_allergic_to(@Allergen::Shellfish))
}

#[test]
fn allergic_to_something_but_not_shellfish_shellfish() {
    let allergies = AllergiesTrait::new(10);
    assert!(!allergies.is_allergic_to(@Allergen::Shellfish))
}

#[test]
fn allergic_to_everything_shellfish() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Shellfish))
}

#[test]
fn not_allergic_to_anything_strawberries() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Strawberries))
}

#[test]
fn allergic_only_to_strawberries_strawberries() {
    let allergies = AllergiesTrait::new(8);
    assert!(allergies.is_allergic_to(@Allergen::Strawberries))
}

#[test]
fn allergic_to_strawberries_and_something_else_strawberries() {
    let allergies = AllergiesTrait::new(28);
    assert!(allergies.is_allergic_to(@Allergen::Strawberries))
}

#[test]
fn allergic_to_something_but_not_strawberries_strawberries() {
    let allergies = AllergiesTrait::new(20);
    assert!(!allergies.is_allergic_to(@Allergen::Strawberries))
}

#[test]
fn allergic_to_everything_strawberries() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Strawberries))
}

#[test]
fn not_allergic_to_anything_tomatoes() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Tomatoes))
}

#[test]
fn allergic_only_to_tomatoes_tomatoes() {
    let allergies = AllergiesTrait::new(16);
    assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
}

#[test]
fn allergic_to_tomatoes_and_something_else_tomatoes() {
    let allergies = AllergiesTrait::new(56);
    assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
}

#[test]
fn allergic_to_something_but_not_tomatoes_tomatoes() {
    let allergies = AllergiesTrait::new(40);
    assert!(!allergies.is_allergic_to(@Allergen::Tomatoes))
}

#[test]
fn allergic_to_everything_tomatoes() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
}

#[test]
fn not_allergic_to_anything_chocolate() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Chocolate))
}

#[test]
fn allergic_only_to_chocolate_chocolate() {
    let allergies = AllergiesTrait::new(32);
    assert!(allergies.is_allergic_to(@Allergen::Chocolate))
}

#[test]
fn allergic_to_chocolate_and_something_else_chocolate() {
    let allergies = AllergiesTrait::new(112);
    assert!(allergies.is_allergic_to(@Allergen::Chocolate))
}

#[test]
fn allergic_to_something_but_not_chocolate_chocolate() {
    let allergies = AllergiesTrait::new(80);
    assert!(!allergies.is_allergic_to(@Allergen::Chocolate))
}

#[test]
fn allergic_to_everything_chocolate() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Chocolate))
}

#[test]
fn not_allergic_to_anything_pollen() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Pollen))
}

#[test]
fn allergic_only_to_pollen_pollen() {
    let allergies = AllergiesTrait::new(64);
    assert!(allergies.is_allergic_to(@Allergen::Pollen))
}

#[test]
fn allergic_to_pollen_and_something_else_pollen() {
    let allergies = AllergiesTrait::new(224);
    assert!(allergies.is_allergic_to(@Allergen::Pollen))
}

#[test]
fn allergic_to_something_but_not_pollen_pollen() {
    let allergies = AllergiesTrait::new(160);
    assert!(!allergies.is_allergic_to(@Allergen::Pollen))
}

#[test]
fn allergic_to_everything_pollen() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Pollen))
}

#[test]
fn not_allergic_to_anything_cats() {
    let allergies = AllergiesTrait::new(0);
    assert!(!allergies.is_allergic_to(@Allergen::Cats))
}

#[test]
fn allergic_only_to_cats_cats() {
    let allergies = AllergiesTrait::new(128);
    assert!(allergies.is_allergic_to(@Allergen::Cats))
}

#[test]
fn allergic_to_cats_and_something_else_cats() {
    let allergies = AllergiesTrait::new(192);
    assert!(allergies.is_allergic_to(@Allergen::Cats))
}

#[test]
fn allergic_to_something_but_not_cats_cats() {
    let allergies = AllergiesTrait::new(64);
    assert!(!allergies.is_allergic_to(@Allergen::Cats))
}

#[test]
fn allergic_to_everything_cats() {
    let allergies = AllergiesTrait::new(255);
    assert!(allergies.is_allergic_to(@Allergen::Cats))
}

#[test]
fn no_allergies() {
    let allergies = AllergiesTrait::new(0).allergies();
    let expected = @array![];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn just_eggs() {
    let allergies = AllergiesTrait::new(1).allergies();
    let expected = @array![Allergen::Eggs];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn just_peanuts() {
    let allergies = AllergiesTrait::new(2).allergies();
    let expected = @array![Allergen::Peanuts];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn just_strawberries() {
    let allergies = AllergiesTrait::new(8).allergies();
    let expected = @array![Allergen::Strawberries];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn eggs_and_peanuts() {
    let allergies = AllergiesTrait::new(3).allergies();
    let expected = @array![Allergen::Eggs, Allergen::Peanuts];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn more_than_eggs_but_not_peanuts() {
    let allergies = AllergiesTrait::new(5).allergies();
    let expected = @array![Allergen::Eggs, Allergen::Shellfish];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn lots_of_stuff() {
    let allergies = AllergiesTrait::new(248).allergies();
    let expected = @array![
        Allergen::Strawberries,
        Allergen::Tomatoes,
        Allergen::Chocolate,
        Allergen::Pollen,
        Allergen::Cats,
    ];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn everything() {
    let allergies = AllergiesTrait::new(255).allergies();
    let expected = @array![
        Allergen::Eggs,
        Allergen::Peanuts,
        Allergen::Shellfish,
        Allergen::Strawberries,
        Allergen::Tomatoes,
        Allergen::Chocolate,
        Allergen::Pollen,
        Allergen::Cats,
    ];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn no_allergen_score_parts() {
    let allergies = AllergiesTrait::new(509).allergies();
    let expected = @array![
        Allergen::Eggs,
        Allergen::Shellfish,
        Allergen::Strawberries,
        Allergen::Tomatoes,
        Allergen::Chocolate,
        Allergen::Pollen,
        Allergen::Cats,
    ];

    compare_allergy_vectors(expected, @allergies);
}

#[test]
fn no_allergen_score_parts_without_highest_valid_score() {
    let allergies = AllergiesTrait::new(257).allergies();
    let expected = @array![Allergen::Eggs];

    compare_allergy_vectors(expected, @allergies);
}

