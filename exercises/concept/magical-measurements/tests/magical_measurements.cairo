use magical_measurements::{
    Elixir, Essence, convert_essence_to_elixir, convert_signed_to_unsigned,
    convert_unsigned_to_signed,
};

#[test]
fn test_convert_positive_signed_to_unsigned() {
    let result = convert_signed_to_unsigned(42);
    assert!(result.is_some());
    assert_eq!(result.unwrap(), 42);
}

#[test]
#[ignore]
fn test_convert_negative_signed_to_unsigned() {
    let result = convert_signed_to_unsigned(-42);
    assert!(result.is_none());
}

#[test]
#[ignore]
fn test_convert_zero_signed_to_unsigned() {
    let result = convert_signed_to_unsigned(0);
    assert!(result.is_some());
    assert_eq!(result.unwrap(), 0);
}

#[test]
#[ignore]
fn test_convert_large_signed_to_unsigned() {
    let result = convert_signed_to_unsigned(100000); // Exceeds u16::MAX (65535)
    assert!(result.is_none());
}

#[test]
#[ignore]
fn test_convert_max_u16_signed_to_unsigned() {
    let result = convert_signed_to_unsigned(65535); // u16::MAX
    assert!(result.is_some());
    assert_eq!(result.unwrap(), 65535);
}

#[test]
#[ignore]
fn test_convert_small_unsigned_to_signed() {
    let result = convert_unsigned_to_signed(42);
    assert_eq!(result, 42);
}

#[test]
#[ignore]
fn test_convert_zero_unsigned_to_signed() {
    let result = convert_unsigned_to_signed(0);
    assert_eq!(result, 0);
}

#[test]
#[ignore]
fn test_convert_max_unsigned_to_signed() {
    let result = convert_unsigned_to_signed(65535); // u16::MAX
    assert_eq!(result, 65535);
}

#[test]
#[ignore]
fn test_convert_essence_to_elixir() {
    let essence = Essence { potency: 100 };
    let elixir = convert_essence_to_elixir(essence);
    assert_eq!(elixir.strength, 100);
}

#[test]
#[ignore]
fn test_convert_essence_to_elixir_direct() {
    let essence = Essence { potency: 250 };
    let elixir: Elixir = essence.into();
    assert_eq!(elixir.strength, 250);
}

#[test]
#[ignore]
fn test_convert_essence_to_elixir_zero() {
    let essence = Essence { potency: 0 };
    let elixir = convert_essence_to_elixir(essence);
    assert_eq!(elixir.strength, 0);
}

#[test]
#[ignore]
fn test_convert_essence_to_elixir_max() {
    let essence = Essence { potency: 65535 };
    let elixir = convert_essence_to_elixir(essence);
    assert_eq!(elixir.strength, 65535);
}
