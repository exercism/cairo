/// various weather conditions
#[derive(Drop)]
pub enum WeatherCondition {
    Sunny,
    Rainy,
    Cloudy,
    Stormy,
}

/// primary function for generating weather reports
pub fn get_weather_report(condition: WeatherCondition, temperature: u32) -> ByteArray {
    match condition {
        WeatherCondition::Sunny => get_sunny_forecast(temperature),
        WeatherCondition::Rainy => get_rainy_forecast(temperature),
        WeatherCondition::Cloudy => get_cloudy_forecast(temperature),
        WeatherCondition::Stormy => get_stormy_forecast(temperature),
    }
}

// Helpers to get appropriate forecast messages, the `ByteArray` type will be introduced later

fn get_sunny_forecast(temperature: u32) -> ByteArray {
    format!("Today is SUNNY with a temperature of {temperature} degrees Celsius.")
}

fn get_rainy_forecast(temperature: u32) -> ByteArray {
    format!("Today is RAINY with a temperature of {temperature} degrees Celsius.")
}

fn get_cloudy_forecast(temperature: u32) -> ByteArray {
    format!("Today is CLOUDY with a temperature of {temperature} degrees Celsius.")
}

fn get_stormy_forecast(temperature: u32) -> ByteArray {
    format!("Today is STORMY with a temperature of {temperature} degrees Celsius.")
}
