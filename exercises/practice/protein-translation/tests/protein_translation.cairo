use protein_translation::{parse, CodonsInfoTrait};

#[test]
fn empty_rna_sequence_results_in_no_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna(""), array![]);
}

#[test]
#[ignore]
fn methionine_rna_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUG"), array!["Methionine"]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUU"), array!["Phenylalanine"]);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUC"), array!["Phenylalanine"]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUA"), array!["Leucine"]);
}

#[test]
#[ignore]
fn leucine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUG"), array!["Leucine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCU"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCC"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_3() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCA"), array!["Serine"]);
}

#[test]
#[ignore]
fn serine_rna_sequence_4() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCG"), array!["Serine"]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAU"), array!["Tyrosine"]);
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAC"), array!["Tyrosine"]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGU"), array!["Cysteine"]);
}

#[test]
#[ignore]
fn cysteine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGC"), array!["Cysteine"]);
}

#[test]
#[ignore]
fn tryptophan_rna_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAA"), array![]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAG"), array![]);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_3() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGA"), array![]);
}

#[test]
#[ignore]
fn sequence_of_two_protein_codons_translates_into_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUUUUU"), array!["Phenylalanine", "Phenylalanine"]);
}

#[test]
#[ignore]
fn sequence_of_two_different_protein_codons_translates_into_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUAUUG"), array!["Leucine", "Leucine"]);
}

#[test]
#[ignore]
fn translate_rna_strand_into_correct_protein_list() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUGUUUUGG"), array!["Methionine", "Phenylalanine", "Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_beginning_of_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAGUGG"), array![]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_two_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGGUAG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_three_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUGUUUUAA"), array!["Methionine", "Phenylalanine"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_three_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGGUAGUGG"), array!["Tryptophan"]);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_six_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGGUGUUAUUAAUGGUUU"), array!["Tryptophan", "Cysteine", "Tyrosine"]);
}

#[test]
#[ignore]
fn sequence_of_two_non_stop_codons_does_not_translate_to_a_stop_codon() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUGAUG"), array!["Methionine", "Methionine"]);
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn non_existing_codon_cant_translate() {
    let mut info = parse(make_pairs());
    info.of_rna("AAA");
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn unknown_amino_acids_not_part_of_a_codon_cant_translate() {
    let mut info = parse(make_pairs());
    info.of_rna("XYZ");
}

#[test]
#[ignore]
#[should_panic(expected: ('Invalid codon',))]
fn incomplete_rna_sequence_cant_translate() {
    let mut info = parse(make_pairs());
    info.of_rna("AUGU");
}

#[test]
#[ignore]
fn incomplete_rna_sequence_cantranslate_if_valid_until_a_stop_codon() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUCUUCUAAUGGU"), array!["Phenylalanine", "Phenylalanine"]);
}

// The input data constructor. Returns a list of codon, name pairs.
fn make_pairs() -> Array<(felt252, ByteArray)> {
    let grouped: Array<(ByteArray, Array<felt252>)> = array![
        ("Methionine", array!['AUG']),
        ("Phenylalanine", array!['UUU', 'UUC']),
        ("Leucine", array!['UUA', 'UUG']),
        ("Serine", array!['UCU', 'UCC', 'UCA', 'UCG']),
        ("Tyrosine", array!['UAU', 'UAC']),
        ("Cysteine", array!['UGU', 'UGC']),
        ("Tryptophan", array!['UGG']),
        ("stop codon", array!['UAA', 'UAG', 'UGA']),
    ];
    let mut pairs = ArrayTrait::<(felt252, ByteArray)>::new();
    for (name, codons) in grouped {
        for codon in codons {
            pairs.append((codon, name.clone()));
        };
    };
    pairs
}
