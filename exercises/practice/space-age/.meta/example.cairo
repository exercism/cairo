#[derive(Drop)]
pub struct Mercury {}
#[derive(Drop)]
pub struct Venus {}
#[derive(Drop)]
pub struct Earth {}
#[derive(Drop)]
pub struct Mars {}
#[derive(Drop)]
pub struct Jupiter {}
#[derive(Drop)]
pub struct Saturn {}
#[derive(Drop)]
pub struct Uranus {}
#[derive(Drop)]
pub struct Neptune {}

const MICROSECONDS_IN_A_SECOND: u64 = 1_000_000;

pub trait Planet<T> {
    const PERIOD: u256;
    fn age(
        self: @T, seconds: u256
    ) -> u256 {
        let microseconds = seconds * MICROSECONDS_IN_A_SECOND.into();
        // multiplying with 100 before the division makes the result
        // include the first 2 decimals of the division result
        microseconds * 100 / Self::PERIOD
    }
}

impl MercuryPlanet of Planet<Mercury> {
    const PERIOD: u256 = 7_600_543_819_920;
}

impl VenusPlanet of Planet<Venus> {
    const PERIOD: u256 = 19_414_149_052_176;
}

impl EarthPlanet of Planet<Earth> {
    const PERIOD: u256 = 31_557_600_000_000;
}

impl MarsPlanet of Planet<Mars> {
    const PERIOD: u256 = 59_354_032_690_080;
}

impl JupiterPlanet of Planet<Jupiter> {
    const PERIOD: u256 = 374_355_659_124_000;
}

impl SaturnPlanet of Planet<Saturn> {
    const PERIOD: u256 = 929_292_362_884_800;
}

impl UranusPlanet of Planet<Uranus> {
    const PERIOD: u256 = 2_651_370_019_329_600;
}

impl NeptunePlanet of Planet<Neptune> {
    const PERIOD: u256 = 5_200_418_560_032_000;
}
