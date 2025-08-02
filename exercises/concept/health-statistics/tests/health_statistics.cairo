use health_statistics::*;

const AGE: u32 = 89;
const WEIGHT: u32 = 131;

#[test]
#[ignore]
fn name() {
    let name = "John";
    let user = UserTrait::new(name.clone(), AGE, WEIGHT);
    assert_eq!(user.name(), @name);
}

#[test]
#[ignore]
fn age() {
    let user = UserTrait::new("John", AGE, WEIGHT);
    assert_eq!(user.age(), AGE);
}

#[test]
#[ignore]
fn weight() {
    let user = UserTrait::new("John", AGE, WEIGHT);
    assert_eq!(user.weight(), WEIGHT);
}

#[test]
#[ignore]
fn set_age() {
    let new_age: u32 = 90;
    let mut user = UserTrait::new("John", AGE, WEIGHT);
    user.set_age(new_age);
    assert_eq!(user.age(), new_age);
}

#[test]
#[ignore]
fn set_weight() {
    let new_weight: u32 = 129;
    let mut user = UserTrait::new("John", AGE, WEIGHT);
    user.set_weight(new_weight);
    assert_eq!(user.weight(), new_weight);
}
