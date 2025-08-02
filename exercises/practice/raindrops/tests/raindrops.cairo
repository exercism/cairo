use raindrops::convert;

#[test]
fn the_sound_for_1_is_1() {
    assert_eq!(convert(1), "1");
}

#[test]
#[ignore]
fn the_sound_for_3_is_pling() {
    assert_eq!(convert(3), "Pling");
}

#[test]
#[ignore]
fn the_sound_for_5_is_plang() {
    assert_eq!(convert(5), "Plang");
}

#[test]
#[ignore]
fn the_sound_for_7_is_plong() {
    assert_eq!(convert(7), "Plong");
}

#[test]
#[ignore]
fn the_sound_for_6_is_pling_as_it_has_a_factor_3() {
    assert_eq!(convert(6), "Pling");
}

#[test]
#[ignore]
fn the_sound_for_8_is_8() {
    assert_eq!(convert(8), "8");
}

#[test]
#[ignore]
fn the_sound_for_9_is_pling_as_it_has_a_factor_3() {
    assert_eq!(convert(9), "Pling");
}

#[test]
#[ignore]
fn the_sound_for_10_is_plang_as_it_has_a_factor_5() {
    assert_eq!(convert(10), "Plang");
}

#[test]
#[ignore]
fn the_sound_for_14_is_plong_as_it_has_a_factor_7() {
    assert_eq!(convert(14), "Plong");
}

#[test]
#[ignore]
fn the_sound_for_15_is_plingplang_as_it_has_factors_3_and_5() {
    assert_eq!(convert(15), "PlingPlang");
}

#[test]
#[ignore]
fn the_sound_for_21_is_plingplong_as_it_has_factors_3_and_7() {
    assert_eq!(convert(21), "PlingPlong");
}

#[test]
#[ignore]
fn the_sound_for_25_is_plang_as_it_has_a_factor_5() {
    assert_eq!(convert(25), "Plang");
}

#[test]
#[ignore]
fn the_sound_for_27_is_pling_as_it_has_a_factor_3() {
    assert_eq!(convert(27), "Pling");
}

#[test]
#[ignore]
fn the_sound_for_35_is_plangplong_as_it_has_factors_5_and_7() {
    assert_eq!(convert(35), "PlangPlong");
}

#[test]
#[ignore]
fn the_sound_for_49_is_plong_as_it_has_a_factor_7() {
    assert_eq!(convert(49), "Plong");
}

#[test]
#[ignore]
fn the_sound_for_52_is_52() {
    assert_eq!(convert(52), "52");
}

#[test]
#[ignore]
fn the_sound_for_105_is_plingplangplong_as_it_has_factors_3_5_and_7() {
    assert_eq!(convert(105), "PlingPlangPlong");
}

#[test]
#[ignore]
fn the_sound_for_3125_is_plang_as_it_has_a_factor_5() {
    assert_eq!(convert(3125), "Plang");
}
