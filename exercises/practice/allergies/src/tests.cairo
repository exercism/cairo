mod testing_for_eggs_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Eggs))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_eggs() {
        let allergies = AllergiesTrait::new(1);
        assert!(allergies.is_allergic_to(@Allergen::Eggs))
    }

    #[test]
    #[ignore]
    fn allergic_to_eggs_and_something_else() {
        let allergies = AllergiesTrait::new(3);
        assert!(allergies.is_allergic_to(@Allergen::Eggs))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_eggs() {
        let allergies = AllergiesTrait::new(2);
        assert!(!allergies.is_allergic_to(@Allergen::Eggs))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Eggs))
    }
}

mod testing_for_peanuts_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Peanuts))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_peanuts() {
        let allergies = AllergiesTrait::new(2);
        assert!(allergies.is_allergic_to(@Allergen::Peanuts))
    }

    #[test]
    #[ignore]
    fn allergic_to_peanuts_and_something_else() {
        let allergies = AllergiesTrait::new(7);
        assert!(allergies.is_allergic_to(@Allergen::Peanuts))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_peanuts() {
        let allergies = AllergiesTrait::new(5);
        assert!(!allergies.is_allergic_to(@Allergen::Peanuts))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Peanuts))
    }
}

mod testing_for_shellfish_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Shellfish))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_shellfish() {
        let allergies = AllergiesTrait::new(4);
        assert!(allergies.is_allergic_to(@Allergen::Shellfish))
    }

    #[test]
    #[ignore]
    fn allergic_to_shellfish_and_something_else() {
        let allergies = AllergiesTrait::new(14);
        assert!(allergies.is_allergic_to(@Allergen::Shellfish))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_shellfish() {
        let allergies = AllergiesTrait::new(10);
        assert!(!allergies.is_allergic_to(@Allergen::Shellfish))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Shellfish))
    }
}

mod testing_for_strawberries_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Strawberries))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_strawberries() {
        let allergies = AllergiesTrait::new(8);
        assert!(allergies.is_allergic_to(@Allergen::Strawberries))
    }

    #[test]
    #[ignore]
    fn allergic_to_strawberries_and_something_else() {
        let allergies = AllergiesTrait::new(28);
        assert!(allergies.is_allergic_to(@Allergen::Strawberries))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_strawberries() {
        let allergies = AllergiesTrait::new(20);
        assert!(!allergies.is_allergic_to(@Allergen::Strawberries))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Strawberries))
    }
}

mod testing_for_tomatoes_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Tomatoes))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_tomatoes() {
        let allergies = AllergiesTrait::new(16);
        assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
    }

    #[test]
    #[ignore]
    fn allergic_to_tomatoes_and_something_else() {
        let allergies = AllergiesTrait::new(56);
        assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_tomatoes() {
        let allergies = AllergiesTrait::new(40);
        assert!(!allergies.is_allergic_to(@Allergen::Tomatoes))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Tomatoes))
    }
}

mod testing_for_chocolate_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Chocolate))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_chocolate() {
        let allergies = AllergiesTrait::new(32);
        assert!(allergies.is_allergic_to(@Allergen::Chocolate))
    }

    #[test]
    #[ignore]
    fn allergic_to_chocolate_and_something_else() {
        let allergies = AllergiesTrait::new(112);
        assert!(allergies.is_allergic_to(@Allergen::Chocolate))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_chocolate() {
        let allergies = AllergiesTrait::new(80);
        assert!(!allergies.is_allergic_to(@Allergen::Chocolate))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Chocolate))
    }
}

mod testing_for_pollen_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Pollen))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_pollen() {
        let allergies = AllergiesTrait::new(64);
        assert!(allergies.is_allergic_to(@Allergen::Pollen))
    }

    #[test]
    #[ignore]
    fn allergic_to_pollen_and_something_else() {
        let allergies = AllergiesTrait::new(224);
        assert!(allergies.is_allergic_to(@Allergen::Pollen))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_pollen() {
        let allergies = AllergiesTrait::new(160);
        assert!(!allergies.is_allergic_to(@Allergen::Pollen))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Pollen))
    }
}

mod testing_for_cats_allergy {
    use allergies::{Allergen, AllergiesTrait};

    #[test]
    #[ignore]
    fn not_allergic_to_anything() {
        let allergies = AllergiesTrait::new(0);
        assert!(!allergies.is_allergic_to(@Allergen::Cats))
    }

    #[test]
    #[ignore]
    fn allergic_only_to_cats() {
        let allergies = AllergiesTrait::new(128);
        assert!(allergies.is_allergic_to(@Allergen::Cats))
    }

    #[test]
    #[ignore]
    fn allergic_to_cats_and_something_else() {
        let allergies = AllergiesTrait::new(192);
        assert!(allergies.is_allergic_to(@Allergen::Cats))
    }

    #[test]
    #[ignore]
    fn allergic_to_something_but_not_cats() {
        let allergies = AllergiesTrait::new(64);
        assert!(!allergies.is_allergic_to(@Allergen::Cats))
    }

    #[test]
    #[ignore]
    fn allergic_to_everything() {
        let allergies = AllergiesTrait::new(255);
        assert!(allergies.is_allergic_to(@Allergen::Cats))
    }
}

mod list_when {
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
                let mut j = 0;
                while let Option::Some(actual_elem) = actual
                    .get(j) {
                        if actual_elem.unbox() == expected_elem.unbox() {
                            break;
                        }
                        j += 1;
                    };
                if j == actual.len() {
                    panic!("Allergen missing\n  {expected_elem:?} should be in {actual:?}");
                }
                i += 1;
            };
    }


    #[test]
    #[ignore]
    fn no_allergies() {
        let allergies = AllergiesTrait::new(0).allergies();
        let expected = @array![];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
    fn just_eggs() {
        let allergies = AllergiesTrait::new(1).allergies();
        let expected = @array![Allergen::Eggs];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
    fn just_peanuts() {
        let allergies = AllergiesTrait::new(2).allergies();
        let expected = @array![Allergen::Peanuts];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
    fn just_strawberries() {
        let allergies = AllergiesTrait::new(8).allergies();
        let expected = @array![Allergen::Strawberries];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
    fn eggs_and_peanuts() {
        let allergies = AllergiesTrait::new(3).allergies();
        let expected = @array![Allergen::Eggs, Allergen::Peanuts];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
    fn more_than_eggs_but_not_peanuts() {
        let allergies = AllergiesTrait::new(5).allergies();
        let expected = @array![Allergen::Eggs, Allergen::Shellfish];

        compare_allergy_vectors(expected, @allergies);
    }

    #[test]
    #[ignore]
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
    #[ignore]
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
    #[ignore]
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
    #[ignore]
    fn no_allergen_score_parts_without_highest_valid_score() {
        let allergies = AllergiesTrait::new(257).allergies();
        let expected = @array![Allergen::Eggs];

        compare_allergy_vectors(expected, @allergies);
    }
}
