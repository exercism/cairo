trait Greeter<T> {
    fn language_name(self: @T) -> ByteArray;
    fn greet(self: @T, name: ByteArray) -> ByteArray;
}

pub fn say_hello<T, +Greeter<T>, +Drop<T>>(name: ByteArray, greeter: T) -> ByteArray {
    panic!("implement `say_hello`")
}
