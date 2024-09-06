# Instructions

You are tasked with designing a system for processing transactions in a decentralized financial application. The system should handle different types of payment methods and also verify transactions based on a certain limit. You will implement two types of payments: `BankTransfer` and `CreditCard`, each with its own specific details.

Additionally, the system should have a way to globally check whether a transaction exceeds a predefined threshold, independent of the payment method. This will involve a method that checks the transaction limit and takes regular parameters, without being called on an instance of a payment type.

#### **Requirements:**

1. Define a trait `Transaction<T>` that provides a `process(self: @T) -> ByteArray` method for a generic type `T`. The trait should have a default implementation of `process` that returns the string `"(Transaction processed)"`.
2. Define the structs `BankTransfer` and `CreditCard` with the following fields:
    - **BankTransfer**:
        - `from_account: ByteArray`
        - `to_account: ByteArray`
        - `amount: u64`
    - **CreditCard**:
        - `card_number: ByteArray`
        - `card_holder: ByteArray`
        - `amount: u64`
3. Implement the `Transaction` trait for both `BankTransfer` and `CreditCard`:
    - The `process` method for `BankTransfer` should return: `"Processed bank transfer from {from_account} to {to_account} for {amount} units"`.
    - The `process` method for `CreditCard` should return: `"Processed credit card payment for {card_holder} with card {card_number} for {amount} units"`.
4. Define another trait `TransactionLimit` with a method `exceeds_limit(amount: u64, limit: u64) -> bool`. This method checks if a given transaction amount exceeds a predefined limit. It should **not** take `self` as a parameter and should be called as `TransactionLimit::exceeds_limit(amount, limit)`.
5. Implement the `TransactionLimit` trait in a way that makes it available to all payment types.

#### **Functionality:**

- The system should be able to process transactions using the `process` method for `BankTransfer` and `CreditCard`.
- Additionally, you should be able to globally check whether the transaction exceeds a certain limit using `TransactionLimit::exceeds_limit`.
- If no custom `process` implementation is provided for a payment type, the default behavior should return `"(Transaction processed)"`.

#### **Exercise Instructions:**

1. Define the `Transaction` trait with a default implementation for the `process` method.
2. Define the structs `BankTransfer` and `CreditCard`.
3. Implement the `Transaction` trait for both payment types, with custom logic for each in the `process` method.
4. Define the `TransactionLimit` trait with the `exceeds_limit` method that does not take `self` and works globally.
5. Write a `main` function that:
    - Creates instances of `BankTransfer` and `CreditCard`.
    - Processes both transactions.
    - Checks if the transaction exceeds a predefined limit using `TransactionLimit::exceeds_limit`.

#### **Expected Output:**

```shell
Processed bank transfer from 1234-5678 to 9876-5432 for 1000 units
Transaction exceeds limit: true

Processed credit card payment for Alice with card 4111-1111-1111-1111 for 500 units
Transaction exceeds limit: false
```

#### **Bonus Challenge:**

- Implement a new struct `Cryptocurrency` with fields:
  - `from_wallet: ByteArray`
  - `to_wallet: ByteArray`
  - `amount: u64`
- Implement the `Transaction` and `TransactionLimit` traits for `Cryptocurrency` similarly to the other payment types.

#### **Hints:**

- Use the `format!` macro to concatenate strings when implementing the `process` method.
- Make sure `TransactionLimit::exceeds_limit` is called directly from the trait without an instance.

---

This story integrates global transaction verification and payment processing, providing practice with traits that don't require the `self` parameter and multiple trait implementations. Let me know if you have any questions or want to dive into the code!