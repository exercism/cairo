mod create_a_new_clock_with_an_initial_time {
    use clock::{ClockTrait};

    #[test]
    fn on_the_hour() {
        let t: ByteArray = "08:00";
        assert_eq!(ClockTrait::new(8, 0).to_string(), t);
    }

    #[test]
    #[ignore]
    fn past_the_hour() {
        assert_eq!(ClockTrait::new(11, 9).to_string(), "11:09");
    }

    #[test]
    #[ignore]
    fn midnight_is_zero_hours() {
        assert_eq!(ClockTrait::new(24, 0).to_string(), "00:00");
    }

    #[test]
    #[ignore]
    fn hour_rolls_over() {
        assert_eq!(ClockTrait::new(25, 0).to_string(), "01:00");
    }

    #[test]
    #[ignore]
    fn hour_rolls_over_continuously() {
        assert_eq!(ClockTrait::new(100, 0).to_string(), "04:00");
    }

    #[test]
    #[ignore]
    fn sixty_minutes_is_next_hour() {
        assert_eq!(ClockTrait::new(1, 60).to_string(), "02:00");
    }

    #[test]
    #[ignore]
    fn minutes_roll_over() {
        assert_eq!(ClockTrait::new(0, 160).to_string(), "02:40");
    }

    #[test]
    #[ignore]
    fn minutes_roll_over_continuously() {
        assert_eq!(ClockTrait::new(0, 1723).to_string(), "04:43");
    }

    #[test]
    #[ignore]
    fn hours_and_minutes_roll_over() {
        assert_eq!(ClockTrait::new(25, 160).to_string(), "03:40");
    }

    #[test]
    #[ignore]
    fn hours_and_minutes_roll_over_continuously() {
        assert_eq!(ClockTrait::new(201, 3001).to_string(), "11:01");
    }

    #[test]
    #[ignore]
    fn hours_and_minutes_roll_over_to_exactly_midnight() {
        assert_eq!(ClockTrait::new(72, 8640).to_string(), "00:00");
    }

    #[test]
    #[ignore]
    fn negative_hour() {
        assert_eq!(ClockTrait::new(-1, 15).to_string(), "23:15");
    }

    #[test]
    #[ignore]
    fn negative_hour_rolls_over() {
        assert_eq!(ClockTrait::new(-25, 00).to_string(), "23:00");
    }

    #[test]
    #[ignore]
    fn negative_hour_rolls_over_continuously() {
        assert_eq!(ClockTrait::new(-91, 00).to_string(), "05:00");
    }

    #[test]
    #[ignore]
    fn negative_minutes() {
        assert_eq!(ClockTrait::new(1, -40).to_string(), "00:20");
    }

    #[test]
    #[ignore]
    fn negative_minutes_roll_over() {
        assert_eq!(ClockTrait::new(1, -160).to_string(), "22:20");
    }

    #[test]
    #[ignore]
    fn negative_minutes_roll_over_continuously() {
        assert_eq!(ClockTrait::new(1, -4820).to_string(), "16:40");
    }

    #[test]
    #[ignore]
    fn negative_sixty_minutes_is_previous_hour() {
        assert_eq!(ClockTrait::new(2, -60).to_string(), "01:00");
    }

    #[test]
    #[ignore]
    fn negative_one_twenty_minutes_is_two_prev_hours() {
        assert_eq!(ClockTrait::new(1, -120).to_string(), "23:00");
    }

    #[test]
    #[ignore]
    fn negative_hour_and_minutes_both_roll_over() {
        assert_eq!(ClockTrait::new(-25, -160).to_string(), "20:20");
    }

    #[test]
    #[ignore]
    fn negative_hour_and_minutes_both_roll_over_continuously() {
        assert_eq!(ClockTrait::new(-121, -5810).to_string(), "22:10");
    }

    #[test]
    #[ignore]
    fn zero_hour_and_negative_minutes() {
        assert_eq!(ClockTrait::new(0, -22).to_string(), "23:38");
    }
}

mod clock_math {
    use clock::{ClockTrait};

    #[test]
    #[ignore]
    fn add_minutes() {
        let mut clock = ClockTrait::new(10, 0);
        clock = clock.add_minutes(3);
        assert_eq!(clock.to_string(), "10:03");
    }

    #[test]
    #[ignore]
    fn add_no_minutes() {
        let mut clock = ClockTrait::new(6, 41);
        clock = clock.add_minutes(0);
        assert_eq!(clock.to_string(), "06:41");
    }

    #[test]
    #[ignore]
    fn add_to_next_hour() {
        let mut clock = ClockTrait::new(0, 45);
        clock = clock.add_minutes(40);
        assert_eq!(clock.to_string(), "01:25");
    }

    #[test]
    #[ignore]
    fn add_more_than_one_hour() {
        let mut clock = ClockTrait::new(10, 0);
        clock = clock.add_minutes(61);
        assert_eq!(clock.to_string(), "11:01");
    }

    #[test]
    #[ignore]
    fn add_more_than_two_hours_with_carry() {
        let mut clock = ClockTrait::new(0, 45);
        clock = clock.add_minutes(160);
        assert_eq!(clock.to_string(), "03:25");
    }

    #[test]
    #[ignore]
    fn add_across_midnight() {
        let mut clock = ClockTrait::new(23, 59);
        clock = clock.add_minutes(2);
        assert_eq!(clock.to_string(), "00:01");
    }

    #[test]
    #[ignore]
    fn add_more_than_one_day() {
        let mut clock = ClockTrait::new(5, 32);
        clock = clock.add_minutes(1500);
        assert_eq!(clock.to_string(), "06:32");
    }

    #[test]
    #[ignore]
    fn add_more_than_two_days() {
        let mut clock = ClockTrait::new(1, 1);
        clock = clock.add_minutes(3500);
        assert_eq!(clock.to_string(), "11:21");
    }

    #[test]
    #[ignore]
    fn subtract_minutes() {
        let mut clock = ClockTrait::new(10, 3);
        clock = clock.add_minutes(-3);
        assert_eq!(clock.to_string(), "10:00");
    }

    #[test]
    #[ignore]
    fn subtract_to_previous_hour() {
        let mut clock = ClockTrait::new(10, 3);
        clock = clock.add_minutes(-30);
        assert_eq!(clock.to_string(), "09:33");
    }

    #[test]
    #[ignore]
    fn subtract_more_than_an_hour() {
        let mut clock = ClockTrait::new(10, 3);
        clock = clock.add_minutes(-70);
        assert_eq!(clock.to_string(), "08:53");
    }

    #[test]
    #[ignore]
    fn subtract_across_midnight() {
        let mut clock = ClockTrait::new(0, 3);
        clock = clock.add_minutes(-4);
        assert_eq!(clock.to_string(), "23:59");
    }

    #[test]
    #[ignore]
    fn subtract_more_than_two_hours() {
        let mut clock = ClockTrait::new(0, 0);
        clock = clock.add_minutes(-160);
        assert_eq!(clock.to_string(), "21:20");
    }

    #[test]
    #[ignore]
    fn subtract_more_than_two_hours_with_borrow() {
        let mut clock = ClockTrait::new(6, 15);
        clock = clock.add_minutes(-160);
        assert_eq!(clock.to_string(), "03:35");
    }

    #[test]
    #[ignore]
    fn subtract_more_than_one_day() {
        let mut clock = ClockTrait::new(5, 32);
        clock = clock.add_minutes(-1500);
        assert_eq!(clock.to_string(), "04:32");
    }

    #[test]
    #[ignore]
    fn subtract_more_than_two_days() {
        let mut clock = ClockTrait::new(2, 20);
        clock = clock.add_minutes(-3000);
        assert_eq!(clock.to_string(), "00:20");
    }
}

//
// Test Equality
//
mod compare_two_clocks_for_equality {
    use clock::{ClockTrait};

    #[test]
    #[ignore]
    fn clocks_with_same_time() {
        assert_eq!(ClockTrait::new(15, 37), ClockTrait::new(15, 37));
    }

    #[test]
    #[ignore]
    fn clocks_a_minute_apart() {
        assert_ne!(ClockTrait::new(15, 36), ClockTrait::new(15, 37));
    }

    #[test]
    #[ignore]
    fn clocks_an_hour_apart() {
        assert_ne!(ClockTrait::new(14, 37), ClockTrait::new(15, 37));
    }

    #[test]
    #[ignore]
    fn clocks_with_hour_overflow() {
        assert_eq!(ClockTrait::new(10, 37), ClockTrait::new(34, 37));
    }

    #[test]
    #[ignore]
    fn clocks_with_hour_overflow_by_several_days() {
        assert_eq!(ClockTrait::new(99, 11), ClockTrait::new(3, 11));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_hour() {
        assert_eq!(ClockTrait::new(-2, 40), ClockTrait::new(22, 40));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_hour_that_wraps() {
        assert_eq!(ClockTrait::new(-31, 3), ClockTrait::new(17, 3));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_hour_that_wraps_multiple_times() {
        assert_eq!(ClockTrait::new(-83, 49), ClockTrait::new(13, 49));
    }

    #[test]
    #[ignore]
    fn clocks_with_minute_overflow() {
        assert_eq!(ClockTrait::new(0, 1441), ClockTrait::new(0, 1));
    }

    #[test]
    #[ignore]
    fn clocks_with_minute_overflow_by_several_days() {
        assert_eq!(ClockTrait::new(2, 4322), ClockTrait::new(2, 2));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_minute() {
        assert_eq!(ClockTrait::new(3, -20), ClockTrait::new(2, 40));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_minute_that_wraps() {
        assert_eq!(ClockTrait::new(5, -1490), ClockTrait::new(4, 10));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_minute_that_wraps_multiple_times() {
        assert_eq!(ClockTrait::new(6, -4305), ClockTrait::new(6, 15));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_hours_and_minutes() {
        assert_eq!(ClockTrait::new(-12, -268), ClockTrait::new(7, 32));
    }

    #[test]
    #[ignore]
    fn clocks_with_negative_hours_and_minutes_that_wrap() {
        assert_eq!(ClockTrait::new(-54, -11_513), ClockTrait::new(18, 7));
    }

    #[test]
    #[ignore]
    fn full_clock_and_zeroed_clock() {
        assert_eq!(ClockTrait::new(24, 0), ClockTrait::new(0, 0));
    }
}
