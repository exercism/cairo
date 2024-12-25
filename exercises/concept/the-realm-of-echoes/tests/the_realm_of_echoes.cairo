use the_realm_of_echoes::{EchoStone, format_magical_chant};

#[test]
fn test_format_magical_chant() {
    let result = format_magical_chant("Spark", "Shine", "Glow");
    assert_eq!(result, "Spark-Shine-Glow");
}

#[test]
#[ignore]
fn test_stringify_echo_stone() {
    let stone = EchoStone { power: 100, duration: 300 };
    assert_eq!(format!("{stone}"), "EchoStone [power: 100, duration: 300]");
}

#[test]
#[ignore]
fn test_debug_echo_stone() {
    let stone = EchoStone { power: 100, duration: 300 };
    assert_eq!(format!("{:?}", stone), "Debugging EchoStone: { power: 100, duration: 300 }");
}
