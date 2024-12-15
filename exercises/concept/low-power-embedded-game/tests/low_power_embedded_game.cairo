mod divmod {
    use low_power_embedded_game::DivmodTrait;

    #[test]
    fn example() {
        let dividend: u16 = 10;
        assert_eq!(dividend.divmod(3), (3, 1));
    }

    #[test]
    #[ignore]
    fn powerup() {
        let dividend: u16 = 100;
        assert_eq!(dividend.divmod(3), (33, 1));
    }

    #[test]
    #[ignore]
    fn less() {
        let dividend: u16 = 3;
        assert_eq!(dividend.divmod(10), (0, 3));
    }

    #[test]
    #[ignore]
    fn eq() {
        let dividend: u16 = 3;
        assert_eq!(dividend.divmod(3), (1, 0));
    }

    #[test]
    #[ignore]
    fn multiple() {
        let dividend: u16 = 9;
        assert_eq!(dividend.divmod(3), (3, 0));
    }
}

mod evens {
    use low_power_embedded_game::EvensTrait;

    #[test]
    #[ignore]
    fn strs() {
        let arr: Array<felt252> = array![
            'You', 'really', 'must', 'never', 'be', 'above', 'joking.',
        ];
        assert_eq!(arr.evens(), array!['You', 'must', 'be', 'joking.']);
    }

    #[test]
    #[ignore]
    fn simple_u16() {
        let arr: Array<u16> = array![0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        assert_eq!(arr.evens(), array![0, 2, 4, 6, 8]);
    }

    #[test]
    #[ignore]
    fn reverse_u16() {
        let arr: Array<u16> = array![10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
        assert_eq!(arr.evens(), array![10, 8, 6, 4, 2, 0]);
    }

    #[test]
    #[ignore]
    fn offset_u16() {
        let arr: Array<u16> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
        assert_eq!(arr.evens(), array![1, 3, 5, 7, 9]);
    }
}

mod manhattan {
    use low_power_embedded_game::{Position, PositionTrait};

    #[test]
    #[ignore]
    fn origin() {
        let p: Position = (0, 0);
        assert_eq!(p.manhattan(), 0);
    }

    #[test]
    #[ignore]
    fn q1_unit() {
        let p: Position = (1, 1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    #[ignore]
    fn q2_unit() {
        let p: Position = (1, -1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    #[ignore]
    fn q3_unit() {
        let p: Position = (-1, -1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    #[ignore]
    fn q4_unit() {
        let p: Position = (-1, 1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    #[ignore]
    fn relative_prime() {
        let p: Position = (30, 70);
        assert_eq!(p.manhattan(), 100);
    }
}
