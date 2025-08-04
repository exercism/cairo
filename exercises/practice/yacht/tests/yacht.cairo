use yacht::{Category, score};

#[test]
fn is_yacht() {
    let dice = [5, 5, 5, 5, 5];
    let category = Category::Yacht;
    let output = score(dice, category);
    let expected = 50;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn not_yacht() {
    let dice = [1, 3, 3, 2, 5];
    let category = Category::Yacht;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn ones() {
    let dice = [1, 1, 1, 3, 5];
    let category = Category::Ones;
    let output = score(dice, category);
    let expected = 3;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn ones_out_of_order() {
    let dice = [3, 1, 1, 5, 1];
    let category = Category::Ones;
    let output = score(dice, category);
    let expected = 3;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn no_ones() {
    let dice = [4, 3, 6, 5, 5];
    let category = Category::Ones;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn twos() {
    let dice = [2, 3, 4, 5, 6];
    let category = Category::Twos;
    let output = score(dice, category);
    let expected = 2;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn fours() {
    let dice = [1, 4, 1, 4, 1];
    let category = Category::Fours;
    let output = score(dice, category);
    let expected = 8;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yacht_counted_as_threes() {
    let dice = [3, 3, 3, 3, 3];
    let category = Category::Threes;
    let output = score(dice, category);
    let expected = 15;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yacht_of_3s_counted_as_fives() {
    let dice = [3, 3, 3, 3, 3];
    let category = Category::Fives;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn fives() {
    let dice = [1, 5, 3, 5, 3];
    let category = Category::Fives;
    let output = score(dice, category);
    let expected = 10;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sixes() {
    let dice = [2, 3, 4, 5, 6];
    let category = Category::Sixes;
    let output = score(dice, category);
    let expected = 6;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn full_house_two_small_three_big() {
    let dice = [2, 2, 4, 4, 4];
    let category = Category::FullHouse;
    let output = score(dice, category);
    let expected = 16;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn full_house_three_small_two_big() {
    let dice = [5, 3, 3, 5, 3];
    let category = Category::FullHouse;
    let output = score(dice, category);
    let expected = 19;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn two_pair_is_not_a_full_house() {
    let dice = [2, 2, 4, 4, 5];
    let category = Category::FullHouse;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_of_a_kind_is_not_a_full_house() {
    let dice = [1, 4, 4, 4, 4];
    let category = Category::FullHouse;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yacht_is_not_a_full_house() {
    let dice = [2, 2, 2, 2, 2];
    let category = Category::FullHouse;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_of_a_kind() {
    let dice = [6, 6, 4, 6, 6];
    let category = Category::FourOfAKind;
    let output = score(dice, category);
    let expected = 24;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yacht_can_be_scored_as_four_of_a_kind() {
    let dice = [3, 3, 3, 3, 3];
    let category = Category::FourOfAKind;
    let output = score(dice, category);
    let expected = 12;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn full_house_is_not_four_of_a_kind() {
    let dice = [3, 3, 3, 5, 5];
    let category = Category::FourOfAKind;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn little_straight() {
    let dice = [3, 5, 4, 1, 2];
    let category = Category::LittleStraight;
    let output = score(dice, category);
    let expected = 30;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn little_straight_as_big_straight() {
    let dice = [1, 2, 3, 4, 5];
    let category = Category::BigStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_in_order_but_not_a_little_straight() {
    let dice = [1, 1, 2, 3, 4];
    let category = Category::LittleStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn no_pairs_but_not_a_little_straight() {
    let dice = [1, 2, 3, 4, 6];
    let category = Category::LittleStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn minimum_is_1_maximum_is_5_but_not_a_little_straight() {
    let dice = [1, 1, 3, 4, 5];
    let category = Category::LittleStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn big_straight() {
    let dice = [4, 6, 2, 5, 3];
    let category = Category::BigStraight;
    let output = score(dice, category);
    let expected = 30;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn big_straight_as_little_straight() {
    let dice = [6, 5, 4, 3, 2];
    let category = Category::LittleStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn no_pairs_but_not_a_big_straight() {
    let dice = [6, 5, 4, 3, 1];
    let category = Category::BigStraight;
    let output = score(dice, category);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn choice() {
    let dice = [3, 3, 5, 6, 6];
    let category = Category::Choice;
    let output = score(dice, category);
    let expected = 23;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yacht_as_choice() {
    let dice = [2, 2, 2, 2, 2];
    let category = Category::Choice;
    let output = score(dice, category);
    let expected = 10;
    assert_eq!(output, expected);
}
