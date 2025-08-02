use high_scores::HighScoresTrait as HighScores;

#[test]
#[ignore]
fn list_of_scores() {
    let expected: Array<u32> = array![30, 50, 20, 70];
    let high_scores = HighScores::new(expected.clone());
    assert_eq!(high_scores.scores(), expected.span());
}

#[test]
#[ignore]
fn latest_score() {
    let high_scores = HighScores::new(array![100, 0, 90, 30]);
    let expected = Option::Some(30);
    assert_eq!(high_scores.latest(), expected);
}

#[test]
#[ignore]
fn personal_best() {
    let high_scores = HighScores::new(array![40, 100, 70]);
    let expected = Option::Some(100);
    assert_eq!(high_scores.personal_best(), expected);
}

#[test]
#[ignore]
fn personal_top_three_from_a_list_of_scores() {
    let high_scores = HighScores::new(array![10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]);
    let expected = array![100, 90, 70].span();
    assert_eq!(high_scores.personal_top_three(), expected);
}

#[test]
#[ignore]
fn personal_top_highest_to_lowest() {
    let high_scores = HighScores::new(array![20, 10, 30]);
    let expected = array![30, 20, 10].span();
    assert_eq!(high_scores.personal_top_three(), expected);
}

#[test]
#[ignore]
fn personal_top_when_there_is_a_tie() {
    let high_scores = HighScores::new(array![40, 20, 40, 30]);
    let expected = array![40, 40, 30].span();
    assert_eq!(high_scores.personal_top_three(), expected);
}

#[test]
#[ignore]
fn personal_top_when_there_are_less_than_3() {
    let high_scores = HighScores::new(array![30, 70]);
    let expected = array![70, 30].span();
    assert_eq!(high_scores.personal_top_three(), expected);
}

#[test]
#[ignore]
fn personal_top_when_there_is_only_one() {
    let high_scores = HighScores::new(array![40]);
    let expected = array![40].span();
    assert_eq!(high_scores.personal_top_three(), expected);
}

#[test]
#[ignore]
fn latest_score_after_personal_top_scores() {
    let high_scores = HighScores::new(array![70, 50, 20, 30]);
    let expected = Option::Some(30);
    high_scores.personal_top_three();
    assert_eq!(high_scores.latest(), expected);
}

#[test]
#[ignore]
fn scores_after_personal_top_scores() {
    let expected: Array<u32> = array![30, 50, 20, 70];
    let high_scores = HighScores::new(expected.clone());
    high_scores.personal_top_three();
    assert_eq!(high_scores.scores(), expected.span());
}

#[test]
#[ignore]
fn latest_score_after_personal_best() {
    let high_scores = HighScores::new(array![20, 70, 15, 25, 30]);
    let expected = Option::Some(30);
    high_scores.personal_best().unwrap();
    assert_eq!(high_scores.latest(), expected);
}

#[test]
#[ignore]
fn scores_after_personal_best() {
    let expected: Array<u32> = array![20, 70, 15, 25, 30];
    let high_scores = HighScores::new(expected.clone());
    high_scores.personal_best().unwrap();
    assert_eq!(high_scores.scores(), expected.span());
}
