use weather_report::{WeatherCondition, get_weather_report};

#[test]
fn reports_sunny_weather() {
    assert_eq!(
        get_weather_report(WeatherCondition::Sunny, 30),
        "Today is SUNNY with a temperature of 30 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn reports_rainy_weather() {
    assert_eq!(
        get_weather_report(WeatherCondition::Rainy, 25),
        "Today is RAINY with a temperature of 25 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn reports_cloudy_weather() {
    assert_eq!(
        get_weather_report(WeatherCondition::Cloudy, 27),
        "Today is CLOUDY with a temperature of 27 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn get_weather_report_sunny() {
    assert_eq!(
        get_weather_report(WeatherCondition::Sunny, 35),
        "Today is SUNNY with a temperature of 35 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn get_weather_report_rainy() {
    assert_eq!(
        get_weather_report(WeatherCondition::Rainy, 20),
        "Today is RAINY with a temperature of 20 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn get_weather_report_cloudy() {
    assert_eq!(
        get_weather_report(WeatherCondition::Cloudy, 22),
        "Today is CLOUDY with a temperature of 22 degrees Celsius.",
    );
}

#[test]
#[ignore]
fn add_stormy_variant() {
    assert_eq!(
        get_weather_report(WeatherCondition::Stormy, 15),
        "Today is STORMY with a temperature of 15 degrees Celsius.",
    );
}
