use roman_numerals::Roman;

#[test]
fn number_1_is_i() {
    let input = 1_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "I";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_2_is_ii() {
    let input = 2_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "II";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_3_is_iii() {
    let input = 3_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "III";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_4_is_iv() {
    let input = 4_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "IV";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_5_is_v() {
    let input = 5_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "V";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_6_is_vi() {
    let input = 6_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "VI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_9_is_ix() {
    let input = 9_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "IX";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_16_is_xvi() {
    let input = 16_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "XVI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_27_is_xxvii() {
    let input = 27_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "XXVII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_48_is_xlviii() {
    let input = 48_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "XLVIII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_49_is_xlix() {
    let input = 49_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "XLIX";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_59_is_lix() {
    let input = 59_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "LIX";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_66_is_lxvi() {
    let input = 66_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "LXVI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_93_is_xciii() {
    let input = 93_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "XCIII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_141_is_cxli() {
    let input = 141_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "CXLI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_163_is_clxiii() {
    let input = 163_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "CLXIII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_166_is_clxvi() {
    let input = 166_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "CLXVI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_402_is_cdii() {
    let input = 402_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "CDII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_575_is_dlxxv() {
    let input = 575_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "DLXXV";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_666_is_dclxvi() {
    let input = 666_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "DCLXVI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_911_is_cmxi() {
    let input = 911_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "CMXI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_1024_is_mxxiv() {
    let input = 1024_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MXXIV";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_1666_is_mdclxvi() {
    let input = 1666_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MDCLXVI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_3000_is_mmm() {
    let input = 3000_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MMM";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_3001_is_mmmi() {
    let input = 3001_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MMMI";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_3888_is_mmmdccclxxxviii() {
    let input = 3888_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MMMDCCCLXXXVIII";
    assert_eq!(output.into(), expected);
}

#[test]
fn number_3999_is_mmmcmxcix() {
    let input = 3999_u32;
    let output: Roman = input.into();
    let expected: ByteArray = "MMMCMXCIX";
    assert_eq!(output.into(), expected);
}
