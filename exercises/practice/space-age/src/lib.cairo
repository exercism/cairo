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

trait Planet<T> {
    const PERIOD: u256;
    fn age(self: @T, seconds: u256) -> u256 {
        panic!("implement `Planet<T>::age`")
    }
}

pub fn age<T, +Drop<T>, +Planet<T>>(planet: T, seconds: u256) -> u256 {
    panic!("implement `age`")
}

impl MercuryPlanet of Planet<Mercury> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl VenusPlanet of Planet<Venus> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl EarthPlanet of Planet<Earth> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl MarsPlanet of Planet<Mars> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl JupiterPlanet of Planet<Jupiter> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl SaturnPlanet of Planet<Saturn> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl UranusPlanet of Planet<Uranus> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}

impl NeptunePlanet of Planet<Neptune> {
    const PERIOD: u256 = 0; // UPDATE THIS TO ACTUAL PERIOD
}
