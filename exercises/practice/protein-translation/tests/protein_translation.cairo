use protein_translation::{proteins, AminoAcid};

#[test]
#[ignore]
fn empty_rna_sequence_results_in_no_proteins() {
    assert_eq!(proteins(""), array![]);
}

#[test]
#[ignore]
fn methionine_rna_sequence() {
    assert_eq!(proteins("AUG"), array![AminoAcid::Methionine]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_1() {
    assert_eq!(proteins("UUU"), array![AminoAcid::Phenylalanine]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_2() {
    assert_eq!(proteins("UUC"), array![AminoAcid::Phenylalanine]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_1() {
    assert_eq!(proteins("UUA"), array![AminoAcid::Leucine]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_2() {
    assert_eq!(proteins("UUG"), array![AminoAcid::Leucine]);
}

#[test]
#[ignore]
fn serine_rna_sequence_1() {
    assert_eq!(proteins("UCU"), array![AminoAcid::Serine]);
}

#[test]
#[ignore]
fn serine_rna_sequence_2() {
    assert_eq!(proteins("UCC"), array![AminoAcid::Serine]);
}

#[test]
#[ignore]
fn serine_rna_sequence_3() {
    assert_eq!(proteins("UCA"), array![AminoAcid::Serine]);
}

#[test]
#[ignore]
fn serine_rna_sequence_4() {
    assert_eq!(proteins("UCG"), array![AminoAcid::Serine]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_1() {
    assert_eq!(proteins("UAU"), array![AminoAcid::Tyrosine]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_2() {
    assert_eq!(proteins("UAC"), array![AminoAcid::Tyrosine]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_1() {
    assert_eq!(proteins("UGU"), array![AminoAcid::Cysteine]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_2() {
    assert_eq!(proteins("UGC"), array![AminoAcid::Cysteine]);
}

#[test]
#[ignore]
fn tryptophan_rna_sequence() {
    assert_eq!(proteins("UGG"), array![AminoAcid::Tryptophan]);
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
    assert_eq!(proteins("UUUUUU"), array![AminoAcid::Phenylalanine, AminoAcid::Phenylalanine]);
}

#[test]
#[ignore]
fn sequence_of_two_different_protein_codons_translates_into_proteins() {
    assert_eq!(proteins("UUAUUG"), array![AminoAcid::Leucine, AminoAcid::Leucine]);
}

#[test]
#[ignore]
fn translate_rna_strand_into_correct_protein_list() {
    assert_eq!(
        proteins("AUGUUUUGG"),
        array![AminoAcid::Methionine, AminoAcid::Phenylalanine, AminoAcid::Tryptophan],
    );
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_beginning_of_sequence() {
    assert_eq!(proteins("UAGUGG"), array![]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_two_codon_sequence() {
    assert_eq!(proteins("UGGUAG"), array![AminoAcid::Tryptophan]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_three_codon_sequence() {
    assert_eq!(proteins("AUGUUUUAA"), array![AminoAcid::Methionine, AminoAcid::Phenylalanine]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_three_codon_sequence() {
    assert_eq!(proteins("UGGUAGUGG"), array![AminoAcid::Tryptophan]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_six_codon_sequence() {
    assert_eq!(
        proteins("UGGUGUUAUUAAUGGUUU"),
        array![AminoAcid::Tryptophan, AminoAcid::Cysteine, AminoAcid::Tyrosine],
    );
}

#[test]
#[ignore]
fn sequence_of_two_non_stop_codons_does_not_translate_to_a_stop_codon() {
    assert_eq!(proteins("AUGAUG"), array![AminoAcid::Methionine, AminoAcid::Methionine]);
}

#[test]
#[ignore]
#[should_panic(expected: ("Invalid codon",))]
fn unknown_amino_acids_not_part_of_a_codon_cant_translate() {
    proteins("XYZ");
}

#[test]
#[ignore]
#[should_panic(expected: ("Invalid codon",))]
fn incomplete_rna_sequence_cant_translate() {
    proteins("AUGU");
}

#[test]
#[ignore]
fn incomplete_rna_sequence_can_translate_if_valid_until_a_stop_codon() {
    assert_eq!(
        proteins("UUCUUCUAAUGGU"), array![AminoAcid::Phenylalanine, AminoAcid::Phenylalanine],
    );
}
