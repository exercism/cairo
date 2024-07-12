mod divmod {
    use low_power_embedded_game::DivmodTrait;

    #[test]
    fn example() {
        let dividend: u16 = 10;
        assert_eq!(dividend.divmod(3), (3, 1));
    }

    #[test]
    fn powerup() {
        let dividend: u16 = 100;
        assert_eq!(dividend.divmod(3), (33, 1));
    }

    #[test]
    fn less() {
        let dividend: u16 = 3;
        assert_eq!(dividend.divmod(10), (0, 3));
    }

    #[test]
    fn eq() {
        let dividend: u16 = 3;
        assert_eq!(dividend.divmod(3), (1, 0));
    }

    #[test]
    fn multiple() {
        let dividend: u16 = 9;
        assert_eq!(dividend.divmod(3), (3, 0));
    }
}

mod evens {
    use core::byte_array::ByteArrayTrait;
    use low_power_embedded_game::EvensTrait;

    #[test]
    fn strs() {
        let arr: Array<felt252> = array![
            'You', 'really', 'must', 'never', 'be', 'above', 'joking.'
        ];
        assert_eq!(arr.evens(), array!['You', 'must', 'be', 'joking.']);
    }

    #[test]
    fn simple_u16() {
        let arr: Array<u16> = array![0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        assert_eq!(arr.evens(), array![0, 2, 4, 6, 8]);
    }

    #[test]
    fn reverse_u16() {
        let arr: Array<u16> = array![10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
        assert_eq!(arr.evens(), array![10, 8, 6, 4, 2, 0]);
    }

    #[test]
    fn offset_u16() {
        let arr: Array<u16> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
        assert_eq!(arr.evens(), array![1, 3, 5, 7, 9]);
    }
}

mod manhattan {
    use core::byte_array::ByteArrayTrait;
    use low_power_embedded_game::{Position, PositionTrait};
    use core::fmt::{Debug, Formatter, Error};

    impl IDebug of Debug<i16> {
        fn fmt(self: @i16, ref f: Formatter) -> Result<(), Error> {
            if *self < 0 {
                f.buffer.append(@"-");
            }
            let abs_value = if *self < 0 {
                *self * -1
            } else {
                *self
            };
            let abs_value: u16 = abs_value.try_into().unwrap();
            f.buffer.append(@format!("{}", abs_value));
            Result::Ok(())
        }
    }

    #[test]
    fn origin() {
        let p: Position = (0, 0);
        assert_eq!(p.manhattan(), 0);
    }

    #[test]
    fn q1_unit() {
        let p: Position = (1, 1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    fn q2_unit() {
        let p: Position = (1, -1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    fn q3_unit() {
        let p: Position = (-1, -1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    fn q4_unit() {
        let p: Position = (-1, 1);
        assert_eq!(p.manhattan(), 2);
    }

    #[test]
    fn relative_prime() {
        let p: Position = (30, 70);
        assert_eq!(p.manhattan(), 100);
    }
}
