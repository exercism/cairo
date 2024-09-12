use protein_translation::proteins;

#[test]
fn empty_rna_sequence_results_in_no_proteins() {
    assert_eq!(proteins(""), array![]);
}

#[test]
#[ignore]
fn methionine_rna_sequence() {
    assert_eq!(proteins("AUG"), array!["Methionine"]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_1() {
    assert_eq!(proteins("UUU"), array!["Phenylalanine"]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_2() {
    assert_eq!(proteins("UUC"), array!["Phenylalanine"]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_1() {
    assert_eq!(proteins("UUA"), array!["Leucine"]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_2() {
    assert_eq!(proteins("UUG"), array!["Leucine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_1() {
    assert_eq!(proteins("UCU"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_2() {
    assert_eq!(proteins("UCC"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_3() {
    assert_eq!(proteins("UCA"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_4() {
    assert_eq!(proteins("UCG"), array!["Serine"]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_1() {
    assert_eq!(proteins("UAU"), array!["Tyrosine"]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_2() {
    assert_eq!(proteins("UAC"), array!["Tyrosine"]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_1() {
    assert_eq!(proteins("UGU"), array!["Cysteine"]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_2() {
    assert_eq!(proteins("UGC"), array!["Cysteine"]);
}

#[test]
#[ignore]
fn tryptophan_rna_sequence() {
    assert_eq!(proteins("UGG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_1() {
    assert_eq!(proteins("UAA"), array![]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_2() {
    assert_eq!(proteins("UAG"), array![]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_3() {
    assert_eq!(proteins("UGA"), array![]);
}

#[test]
#[ignore]
fn sequence_of_two_protein_codons_translates_into_proteins() {
    assert_eq!(proteins("UUUUUU"), array!["Phenylalanine", "Phenylalanine"]);
}

#[test]
#[ignore]
fn sequence_of_two_different_protein_codons_translates_into_proteins() {
    assert_eq!(proteins("UUAUUG"), array!["Leucine", "Leucine"]);
}

#[test]
#[ignore]
fn translate_rna_strand_into_correct_protein_list() {
    assert_eq!(proteins("AUGUUUUGG"), array!["Methionine", "Phenylalanine", "Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_beginning_of_sequence() {
    assert_eq!(proteins("UAGUGG"), array![]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_two_codon_sequence() {
    assert_eq!(proteins("UGGUAG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_three_codon_sequence() {
    assert_eq!(proteins("AUGUUUUAA"), array!["Methionine", "Phenylalanine"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_three_codon_sequence() {
    assert_eq!(proteins("UGGUAGUGG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_six_codon_sequence() {
    assert_eq!(proteins("UGGUGUUAUUAAUGGUUU"), array!["Tryptophan", "Cysteine", "Tyrosine"]);
}

#[test]
#[ignore]
fn sequence_of_two_non_stop_codons_does_not_translate_to_a_stop_codon() {
    assert_eq!(proteins("AUGAUG"), array!["Methionine", "Methionine"]);
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn non_existing_codon_cant_translate() {
    proteins("AAA");
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn unknown_amino_acids_not_part_of_a_codon_cant_translate() {
    proteins("XYZ");
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn incomplete_rna_sequence_cant_translate() {
    proteins("AUGU");
}

#[test]
#[ignore]
fn incomplete_rna_sequence_cantranslate_if_valid_until_a_stop_codon() {
    assert_eq!(proteins("UUCUUCUAAUGGU"), array!["Phenylalanine", "Phenylalanine"]);
}
