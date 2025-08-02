use welcome_to_tech_palace::*;

#[test]
#[ignore]
fn welcome_message_for_customer_with_first_letter_capitalized() {
    let customer = 'Judy';
    let actual = welcome_message(customer);
    let expected = "Welcome to the Tech Palace, JUDY";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn welcome_message_for_customer_with_only_lowercase_letters() {
    let customer = 'lars';
    let actual = welcome_message(customer);
    let expected = "Welcome to the Tech Palace, LARS";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn welcome_message_for_customer_with_dash_in_name() {
    let customer = 'Peter-James';
    let actual = welcome_message(customer);
    let expected = "Welcome to the Tech Palace, PETER-JAMES";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn welcome_message_for_customer_with_only_uppercase_letters() {
    let customer = 'MJ';
    let actual = welcome_message(customer);
    let expected = "Welcome to the Tech Palace, MJ";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn add_border_with_10_stars_per_line() {
    let welcome_msg = "Welcome!";
    let num_stars_per_line = 10;
    let actual = add_border(welcome_msg, num_stars_per_line);
    let expected = "**********\nWelcome!\n**********";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn add_border_with_2_stars_per_line() {
    let welcome_msg = "Hi";
    let num_stars_per_line = 2;
    let actual = add_border(welcome_msg, num_stars_per_line);
    let expected = "**\nHi\n**";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn clean_up_message_with_many_stars_and_leading_and_trailing_whitespace() {
    let old_msg =
        "**************************\n*    BUY NOW, SAVE 10%   *\n**************************";
    let actual = clean_up_message(old_msg);
    let expected = "BUY NOW, SAVE 10%";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn clean_up_message_without_leading_or_trailing_whitespace() {
    let old_msg = "**********\n*DISCOUNT*\n**********";
    let actual = clean_up_message(old_msg);
    let expected = "DISCOUNT";
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn clean_up_message_without_leading_whitespace() {
    let old_msg = "*****\n SALE\n*****";
    let actual = clean_up_message(old_msg);
    let expected = "SALE";
    assert_eq!(expected, actual);
}
