#[derive(Drop)]
pub enum WeatherCondition {
    Sunny,
    Rainy,
    Cloudy,
    Stormy,
}

pub fn get_weather_report(condition: WeatherCondition, temperature: ByteArray) -> ByteArray {
    match condition {
        WeatherCondition::Sunny => format!(
            "Today is SUNNY with a temperature of {temperature} degrees Celsius.",
        ),
        WeatherCondition::Rainy => format!(
            "Today is RAINY with a temperature of {temperature} degrees Celsius.",
        ),
        WeatherCondition::Cloudy => format!(
            "Today is CLOUDY with a temperature of {temperature} degrees Celsius.",
        ),
        WeatherCondition::Stormy => format!(
            "Today is STORMY with a temperature of {temperature} degrees Celsius.",
        ),
    }
}

