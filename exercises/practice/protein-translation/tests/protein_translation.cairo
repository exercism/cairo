use protein_translation::{parse, CodonsInfoTrait};

#[test]
fn methionine() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('AUG'), "methionine");
}

#[test]
#[ignore]
fn cysteine_tgt() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('UGU'), "cysteine");
}

#[test]
#[ignore]
fn stop() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('UAA'), "stop codon");
}

#[test]
#[ignore]
fn valine() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('GUU'), "valine");
}

#[test]
#[ignore]
fn isoleucine() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('AUU'), "isoleucine");
}

#[test]
#[ignore]
fn arginine_cga() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('CGA'), "arginine");
}

#[test]
#[ignore]
fn arginine_aga() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('AGA'), "arginine");
}

#[test]
#[ignore]
fn arginine_agg() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('AGG'), "arginine");
}

#[test]
#[ignore]
fn empty_is_invalid() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for(''), "");
}

#[test]
#[ignore]
fn x_is_not_shorthand_so_is_invalid() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('VWX'), "");
}

#[test]
#[ignore]
fn too_short_is_invalid() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('AU'), "");
}

#[test]
#[ignore]
fn too_long_is_invalid() {
    let mut info = parse(make_pairs());
    assert_eq!(info.name_for('ATTA'), "");
}

#[test]
#[ignore]
fn empty_rna_sequence_results_in_no_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna(""), Option::Some(array![]),);
}

#[test]
#[ignore]
fn methionine_rna_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUG"), Option::Some(array!["methionine"]));
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUU"), Option::Some(array!["phenylalanine"]),);
}

#[test]
#[ignore]
fn phenylalanine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUC"), Option::Some(array!["phenylalanine"]));
}

#[test]
#[ignore]
fn leucine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUA"), Option::Some(array!["leucine"]));
}

#[test]
#[ignore]
fn leucine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUG"), Option::Some(array!["leucine"]));
}

#[test]
#[ignore]
fn serine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCU"), Option::Some(array!["serine"]));
}

#[test]
#[ignore]
fn serine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCC"), Option::Some(array!["serine"]));
}

#[test]
#[ignore]
fn serine_rna_sequence_3() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCA"), Option::Some(array!["serine"]));
}

#[test]
#[ignore]
fn serine_rna_sequence_4() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UCG"), Option::Some(array!["serine"]));
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAU"), Option::Some(array!["tyrosine"]));
}

#[test]
#[ignore]
fn tyrosine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAC"), Option::Some(array!["tyrosine"]));
}

#[test]
#[ignore]
fn cysteine_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGU"), Option::Some(array!["cysteine"]));
}

#[test]
#[ignore]
fn cysteine_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGC"), Option::Some(array!["cysteine"]));
}

#[test]
#[ignore]
fn tryptophan_rna_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGG"), Option::Some(array!["tryptophan"]));
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_1() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAA"), Option::Some(array![]),);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_2() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAG"), Option::Some(array![]),);
}

#[test]
#[ignore]
fn stop_codon_rna_sequence_3() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGA"), Option::Some(array![]),);
}

#[test]
#[ignore]
fn sequence_of_two_protein_codons_translates_into_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUUUUU"), Option::Some(array!["phenylalanine", "phenylalanine"]),);
}

#[test]
#[ignore]
fn sequence_of_two_different_protein_codons_translates_into_proteins() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UUAUUG"), Option::Some(array!["leucine", "leucine"]),);
}

#[test]
#[ignore]
fn translate_rna_strand_into_correct_protein_list() {
    let mut info = parse(make_pairs());
    assert_eq!(
        info.of_rna("AUGUUUUGG"), Option::Some(array!["methionine", "phenylalanine", "tryptophan"]),
    );
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_beginning_of_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UAGUGG"), Option::Some(array![]),);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_two_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGGUAG"), Option::Some(array!["tryptophan"]),);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_at_end_of_three_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("AUGUUUUAA"), Option::Some(array!["methionine", "phenylalanine"]),);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_three_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(info.of_rna("UGGUAGUGG"), Option::Some(array!["tryptophan"]),);
}

#[test]
#[ignore]
fn translation_stops_if_stop_codon_in_middle_of_six_codon_sequence() {
    let mut info = parse(make_pairs());
    assert_eq!(
        info.of_rna("UGGUGUUAUUAAUGGUUU"),
        Option::Some(array!["tryptophan", "cysteine", "tyrosine"]),
    );
}

#[test]
#[ignore]
fn unknown_amino_acids_not_part_of_a_codon_can_t_translate() {
    let mut info = parse(make_pairs());
    let none: Option<Array<ByteArray>> = Option::None;
    assert_eq!(info.of_rna("XYZ"), none);
}

#[test]
#[ignore]
fn incomplete_rna_sequence_can_t_translate() {
    let mut info = parse(make_pairs());
    let none: Option<Array<ByteArray>> = Option::None;
    assert_eq!(info.of_rna("AUGU"), none);
}

#[test]
#[ignore]
fn incomplete_rna_sequence_can_translate_if_valid_until_a_stop_codon() {
    let mut info = parse(make_pairs());
    assert_eq!(
        info.of_rna("UUCUUCUAAUGGU"), Option::Some(array!["phenylalanine", "phenylalanine"]),
    );
}

// The input data constructor. Returns a list of codon, name pairs.
fn make_pairs() -> Array<(felt252, ByteArray)> {
    let mut grouped: Array<(ByteArray, Array<felt252>)> = array![
        ("isoleucine", array!['AUU', 'AUC', 'AUA']),
        ("valine", array!['GUU', 'GUC', 'GUA', 'GUG']),
        ("phenylalanine", array!['UUU', 'UUC']),
        ("methionine", array!['AUG']),
        ("cysteine", array!['UGU', 'UGC']),
        ("alanine", array!['GCU', 'GCC', 'GCA', 'GCG']),
        ("glycine", array!['GGU', 'GGC', 'GGA', 'GGG']),
        ("proline", array!['CCU', 'CCC', 'CCA', 'CCG']),
        ("threonine", array!['ACU', 'ACC', 'ACA', 'ACG']),
        ("serine", array!['UCU', 'UCC', 'UCA', 'UCG']),
        ("tyrosine", array!['UAU', 'UAC']),
        ("tryptophan", array!['UGG']),
        ("glutamine", array!['CAA', 'CAG']),
        ("asparagine", array!['AAU', 'AAC']),
        ("histidine", array!['CAU', 'CAC']),
        ("glutamic acid", array!['GAA', 'GAG']),
        ("aspartic acid", array!['GAU', 'GAC']),
        ("lysine", array!['AAA', 'AAG']),
        ("arginine", array!['CGU', 'CGC', 'CGA', 'CGG', 'AGA', 'AGG']),
        ("leucine", array!['UUA', 'UUG']),
        ("stop codon", array!['UAA', 'UAG', 'UGA']),
    ];
    let mut pairs = ArrayTrait::<(felt252, ByteArray)>::new();
    while let Option::Some((name, mut codons)) = grouped
        .pop_front() {
            while let Option::Some(codon) = codons
                .pop_front() {
                    pairs.append((codon, name.clone()));
                };
        };
    pairs
}
