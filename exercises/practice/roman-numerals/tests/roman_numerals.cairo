use roman_numerals::Roman;

#[test]
fn number_1_is_i() {
    let output: Roman = 1_u32.into();
    let expected: ByteArray = "I";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_2_is_ii() {
    let output: Roman = 2_u32.into();
    let expected: ByteArray = "II";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_3_is_iii() {
    let output: Roman = 3_u32.into();
    let expected: ByteArray = "III";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_4_is_iv() {
    let output: Roman = 4_u32.into();
    let expected: ByteArray = "IV";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_5_is_v() {
    let output: Roman = 5_u32.into();
    let expected: ByteArray = "V";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_6_is_vi() {
    let output: Roman = 6_u32.into();
    let expected: ByteArray = "VI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_9_is_ix() {
    let output: Roman = 9_u32.into();
    let expected: ByteArray = "IX";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_16_is_xvi() {
    let output: Roman = 16_u32.into();
    let expected: ByteArray = "XVI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_27_is_xxvii() {
    let output: Roman = 27_u32.into();
    let expected: ByteArray = "XXVII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_48_is_xlviii() {
    let output: Roman = 48_u32.into();
    let expected: ByteArray = "XLVIII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_49_is_xlix() {
    let output: Roman = 49_u32.into();
    let expected: ByteArray = "XLIX";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_59_is_lix() {
    let output: Roman = 59_u32.into();
    let expected: ByteArray = "LIX";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_66_is_lxvi() {
    let output: Roman = 66_u32.into();
    let expected: ByteArray = "LXVI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_93_is_xciii() {
    let output: Roman = 93_u32.into();
    let expected: ByteArray = "XCIII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_141_is_cxli() {
    let output: Roman = 141_u32.into();
    let expected: ByteArray = "CXLI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_163_is_clxiii() {
    let output: Roman = 163_u32.into();
    let expected: ByteArray = "CLXIII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_166_is_clxvi() {
    let output: Roman = 166_u32.into();
    let expected: ByteArray = "CLXVI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_402_is_cdii() {
    let output: Roman = 402_u32.into();
    let expected: ByteArray = "CDII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_575_is_dlxxv() {
    let output: Roman = 575_u32.into();
    let expected: ByteArray = "DLXXV";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_666_is_dclxvi() {
    let output: Roman = 666_u32.into();
    let expected: ByteArray = "DCLXVI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_911_is_cmxi() {
    let output: Roman = 911_u32.into();
    let expected: ByteArray = "CMXI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_1024_is_mxxiv() {
    let output: Roman = 1024_u32.into();
    let expected: ByteArray = "MXXIV";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_1666_is_mdclxvi() {
    let output: Roman = 1666_u32.into();
    let expected: ByteArray = "MDCLXVI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_3000_is_mmm() {
    let output: Roman = 3000_u32.into();
    let expected: ByteArray = "MMM";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_3001_is_mmmi() {
    let output: Roman = 3001_u32.into();
    let expected: ByteArray = "MMMI";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_3888_is_mmmdccclxxxviii() {
    let output: Roman = 3888_u32.into();
    let expected: ByteArray = "MMMDCCCLXXXVIII";
    assert_eq!(format!("{output}"), expected);
}

#[test]
#[ignore]
fn number_3999_is_mmmcmxcix() {
    let output: Roman = 3999_u32.into();
    let expected: ByteArray = "MMMCMXCIX";
    assert_eq!(format!("{output}"), expected);
}
