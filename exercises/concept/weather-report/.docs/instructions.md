# Instructions

In this exercise you'll be generating weather reports for a local news station.

## Generate weather reports

You'll start with some stubbed functions and the following enum:

```rust
#[derive(Drop, Clone, PartialEq, Debug)]
pub enum WeatherCondition {
    Sunny,
    Rainy,
    Cloudy,
    Stormy
}
```

You will need to format a weather report like `"Today is <CONDITION> with a temperature of <TEMPERATURE> degrees Celsius."`.
You'll need to implement functions that correspond with weather conditions.

For example, the below snippet demonstrates an expected output for the `get_weather_report` function.

```rust
get_weather_report(WeatherCondition::Rainy, "25")
// Returns: "Today is RAINY with a temperature of 25 degrees Celsius."
```

And for `sunny_day`:

```rust
get_weather_report(WeatherCondition::Sunny, "30")
// Returns: "Today is SUNNY with a temperature of 30 degrees Celsius."
```
