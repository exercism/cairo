trait Greeter<T> {
    fn language_name(self: @T) -> ByteArray;
    fn greet(self: @T, name: ByteArray) -> ByteArray;
}

pub fn say_hello<T, +Greeter<T>, +Drop<T>>(name: ByteArray, greeter: T) -> ByteArray {
    format!("I can speak {}: {}", greeter.language_name(), greeter.greet(name))
}

#[derive(Drop)]
pub struct Italian {}

impl ItalianGreeter of Greeter<Italian> {
    fn language_name(self: @Italian) -> ByteArray {
        "Italian"
    }

    fn greet(self: @Italian, name: ByteArray) -> ByteArray {
        format!("Ciao {name}!")
    }
}

#[derive(Drop)]
pub struct French {}

impl FrenchGreeter of Greeter<French> {
    fn language_name(self: @French) -> ByteArray {
        "French"
    }

    fn greet(self: @French, name: ByteArray) -> ByteArray {
        format!("Bonjour {name}!")
    }
}
