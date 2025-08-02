use the_realm_of_echoes::{EchoStone, format_magical_chant};

const U32_MAX: u32 = 0xFFFFFFFF;

#[test]
#[ignore]
fn format_magical_chant_basic() {
    let chant1 = "abra";
    let chant2 = "cadabra";
    let chant3 = "alakazam";
    assert_eq!(format_magical_chant(chant1, chant2, chant3), "abra-cadabra-alakazam");
}

#[test]
#[ignore]
fn format_magical_chant_empty_strings() {
    let chant1 = "";
    let chant2 = "";
    let chant3 = "";
    assert_eq!(format_magical_chant(chant1, chant2, chant3), "--");
}

#[test]
#[ignore]
fn format_magical_chant_mixed_empty_and_non_empty() {
    let chant1 = "abra";
    let chant2 = "";
    let chant3 = "alakazam";
    assert_eq!(format_magical_chant(chant1, chant2, chant3), "abra--alakazam");
}

#[test]
#[ignore]
fn format_magical_chant_with_special_characters() {
    let chant1 = "ab@ra";
    let chant2 = "ca!dabra";
    let chant3 = "ala#kazam";
    assert_eq!(format_magical_chant(chant1, chant2, chant3), "ab@ra-ca!dabra-ala#kazam");
}

#[test]
#[ignore]
fn echo_stone_display_basic() {
    let stone = EchoStone { power: 100, duration: 50 };
    assert_eq!(format!("{stone}"), "EchoStone [power: 100, duration: 50]");
}

#[test]
#[ignore]
fn echo_stone_display_zero_values() {
    let stone = EchoStone { power: 0, duration: 0 };
    assert_eq!(format!("{stone}"), "EchoStone [power: 0, duration: 0]");
}


#[test]
#[ignore]
fn echo_stone_display_large_values() {
    let stone = EchoStone { power: U32_MAX, duration: U32_MAX };
    assert_eq!(
        format!("{stone}"), format!("EchoStone [power: {}, duration: {}]", U32_MAX, U32_MAX),
    );
}

#[test]
#[ignore]
fn echo_stone_debug_basic() {
    let stone = EchoStone { power: 100, duration: 50 };
    assert_eq!(format!("{stone:?}"), "Debugging EchoStone: { power: 100, duration: 50 }");
}

#[test]
#[ignore]
fn echo_stone_debug_zero_values() {
    let stone = EchoStone { power: 0, duration: 0 };
    assert_eq!(format!("{stone:?}"), "Debugging EchoStone: { power: 0, duration: 0 }");
}

#[test]
#[ignore]
fn echo_stone_debug_large_values() {
    let stone = EchoStone { power: U32_MAX, duration: U32_MAX };
    assert_eq!(
        format!("{stone:?}"),
        format!("Debugging EchoStone: {{ power: {}, duration: {} }}", U32_MAX, U32_MAX),
    );
}
