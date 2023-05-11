# Solidity Fundamentals

Solidity is a high-level, statically-typed, object-oriented programming language designed explicitly to implement smart contracts on blockchain platforms, notably Ethereum. It enables developers to create decentralized applications (dApps) by encoding rules, functions, and state transitions of contracts. Solidity's code is compiled into bytecode, and executed on the Ethereum Virtual Machine (EVM) to facilitate secure, transparent, and trustless interactions between parties. As the primary language for Ethereum development, Solidity has become crucial in the blockchain ecosystem and has contributed significantly to the rise of decentralized finance (DeFi), tokenization, and other innovative applications.

The following are most of the fundamentals on Solidity for anybody to reference at any time.

---

# Index

### Basics

-   [A basic smart contract](#a-basic-smart-contract)
-   [Pragma line](#pragma-line)
-   [Some theory](#some-theory)
-   [Data types](#data-types)
-   [Operators & Type Conversions](#operators-and-type-conversions)
-   [Conditionals](#conditionals)
-   [Arrays](#arrays)
-   [Strings](#strings)
-   [Mappings](#mappings)
-   [Loops](#loops)
-   [Functions And Access Modifiers](#functions-and-access-modifiers)
-   [Sending And Receiving Eth](#sending-and-receiving-eth)
-   [Exceptions and Errors](#exceptions-and-errors)
-   [Self Destruct](#self-destruct)
-   [Events](#events)
-   [Gas Cost and Estimation](#gas-cost-and-estimation)
-   [Math and Arithmetic](#math-and-arithmetic)

### Advanced

-   [Time and Time Units](#time-and-time-units)
-   [Structs](#structs)
-   [Modifiers](#modifiers)
-   [Enums](#time-and-time-units)
-   [Inheritance](#inheritance)
-   [Abstract Contracts](#abstract-contracts)
-   [Interfaces](#interfaces)
-   [Libraries](#libraries)
-   [Contract Storage](#contract-storage)
-   [Optimizing Gas Costs](#optimizing-gas-costs)

---

## A basic smart contract

```solidity
pragma solidity >=0.7.0 <0.9.0; // pragma line

// basic smart contract
contract HelloWorld {
    uint256 number; // define a var

    // functions that interact with var number:
    function store(uint256 num) public {
        number = num;
    }

    function get() public view returns (uint256) {
        return number;
    }
}
```

## Pragma line

The pragma line is placed at the beginning of a code file to indicate the solidity compiler version(s) that can be used for this contract.

```bash
pragma solidity >=0.7.0 <0.9.0;
```

## Some theory

**Transaction**: In the context of blockchains, a transaction (commonly denoted "x") represents a state-changing operation. It may represent the transfer of coins or the invocation of a smart contract.

**Call**: In the context of smart contracts, a call is a free operation that reads information from a smart contract. Calls do not require transactions and cannot modify the state of a smart contract.

**Gas**: In the context of Ethereum, gas is a fee required to execute transactions or smart contracts. Gas is paid in Ether and is denoted in gwei.

**EVM**: EVM stands for Ethereum Virtual Machine and is a computation engine that runs on Ethereum nodes such as miners. The EVM allows for the execution of smart contracts and is the foundation for Ethereum's entire operating structure.

## Data types

Separated into value types and reference types.

### Value types:

-   `uint`: ranges from `uint8`-`uint256`, where the end number is the number of bits that can be stored in the variable. 0 - (2^bits - 1) of availability. Defaults to `uint256`.
-   `int`: same as `uint` but signed.
-   `bool`: `true` and `false`
-   `address`: stores an Ethereum address. Defaults to `0x00...` address. Allocates 20 bytes for size.
-   `bytes`:
-   Commenting: `// commment` and `/* multi-line comment*/`

## Operators and Type Conversions

Just like other programming languages, Solidity has arithmetic operators(`+,-,...`), comparison operators(`==, !=, >, ...`), logical operators(`&&, ||, !`) and assignment operators(`=, +=, *=, ...`).

## Conditionals

Solidity supports conditional logic like `if/else/if else` and the conditional operator(`condition ? do this : else do this`).

Here is an example of a smart contract with a `compare` function that accepts two `int`s and returns `0` if they are the same, `1` if the first argument is greater than the second and `-1` if the second argument is greater:

```Solidity
pragma solidity >=0.4.22 <=0.8.17;

contract Comparison {
    function compare(int256 a, int256 b) public pure returns (int256) {
        if(a > b){
            return 1;
        } else if (a < b) {
            return -1;
        }
        return 0;
    }
}
```

## Arrays

### Fixed-Sized Array

Size is determined when it is created/allocated and cannot change.
Example:

```Solidity
uint[5] fixedArray = [1,2,3,4,5];
```

### Dynamic-Sized Array

Allows elements to be removed and added and can change their size. Can only be defined in storage and have access to methods such as `.push()` and `.pop()`. `delete array[idx]` sets the item at that index to be the default value of that type and does not remove the element from the array.
Example:

```Solidity
uint[] dynamicArray;
```

### Memory Arrays

They need to be fixed in size. Its size cannot change after initialization.
Example:

```Solidity
uint[] memory numbers;
```

### Other useful info

-   `.length` works on both array types.
-   cannot initialize an array with dynamic variable size. instead, use: `uint[] name = new uint[](dynamicSize);`
-   they are reference type, not value type
-   assigning a storage array to a memory array creates a copy of the storage array and assigns it to the memory array
-   memory to memory array creates a reference of the first memory array to the second memory array

## Strings

### Strings

**TLDR: Literal string representation.** The string data type is used to store UTF-8 encoded characters. Strings are not very flexible, are expensive to use, and are difficult to manipulate. For this reason, it is preferred to use the `bytes` type when possible.

### Bytes

**TLDR: Use for dynamic strings.** The `bytes` type represents an array of bytes. It is useful for storing characters as raw data. The `bytes` type must be stored in `memory`, `calldata`, or `storage`. Convert bytes to strings like so: `string(byte variable);`. **Provides index access and have `.length` property.**

Example: `bytes myRawData = "hello world";`.

-   To pass `string` to function, have to put the `memory` keyword like so: `(string memory varName)...`.

## Mappings

In Solidity, the reference data type known as `mapping` allows you to store key-value pairs. Mappings can only be stored in contract storage and are useful for quickly accessing
associated data.

-   Every single key will return some value and if the key does not exist, it will return the default value from such data type. Cannot access the keys, so a common workaround is to have an auxiliary data structure that stores them.
-   Can have nested mappings
-   For this type, it has to be stored somewhere other than the stack (rule from Solidity).
-   If needed to be used inside a function, use `storage` keyword and copy an _original_ map created in the state of the contract (which makes it a reference to the _original_ map). Very limited to be used inside a function.
-   To pass in as a parameter, function declaration should look like: `function x(mapping(uint => uint) storage map) internal { ... }`.
-   **Example** of a smart contract named `Inventory` that declares a state variable named `quantities` that holds a mapping of `uint` to `int` . Each `uint` key will represent the id of a specific item, while each `int` value will be the quantity of that item in the inventory.
    The function `addItem(uint itemId, uint quantity)` adds an item to the inventory by adding it to the `quantities` mapping. If the `itemId` already exists in the mapping it should increment the value associated with the `itemId` key by the passed quantity. The function
    `getQuantity(uint itemId) returns (int)` returns the quantity of the passed `itemId` that is currently stored in the `quantities` mapping. If there is no item with the given `itemId` it returns -1:

```Solidity
pragma solidity >=0.4.22 <=0.8.17;

contract Inventory {
    mapping(uint256 => int256) quantities;

    function addItem(uint256 itemId, uint256 quantity) public {
        quantities[itemId] += int256(quantity);
    }

    function getQuantity(uint256 itemId) public view returns (int256) {
        return  (quantities[itemId] != 0 ? int256(quantities[itemId]) : -1);
    }
}
```

## Loops

Loops in this language are just like many other programming languages. When doing loops, **you cannot be certain how much gas will be used unless you manually computed it. You can run out of gas very quickly.**

### While

```Solidity
while(true){
    continue;
    break;
}
```

### For

Should be careful with the higher bound of `uint` being used.

```Solidity
for (uint i; i<10; i++){
    // ...
}
```

Looping through an array that can have arbitrary length can be too gas costly. It is preferred to use `mapping`s. Example of looping through an array:

```Solidity
for (uint idx; i<array.length; idx++){
    // access element in array like so: array[idx]
}
```

## Functions And Access Modifiers

-   Return multiple values like so: `return (1, 1, 1);`

### Public

`public` is a visibility modifier that can be used to mark variables and functions as accessible from within or outside of the contract. Any variable or function marked as public can be accessed from any location.

### Private

The `private` visibility modifier is used to mark a function or variable as only accessible from within the contract it is defined in. Private functions and variables cannot be accessed from any derived contracts, outside the blockchain or any location other than the contract they are defined in. **_Note: Although private variables cannot be accessed from outside of a contract, their data can still be found and read on the blockchain. This is because the blockchain is publicly available and anybody can view and verify all of the data on the blockchain._**

### Internal

`internal` is a visibility modifier that can be used to mark functions and variables as only accessible from within the contract or any derived contracts. internal functions can only be called from the contract they are defined in.

### External

`external` is a visibility modifier that can be used to mark functions as only callable from outside of the contract itself. external functions can only be called from outside of the blockchain or from another smart contract.

### Pure

**TLDR: Cannot view nor modify state. Used for performing calculations.** A `pure` function is one that does not rely on any contract state to execute. However, `pure` functions can call other `pure` functions and utilize types like structs and enums. Example: `function x() public pure returns (uint){//...}`.

### View

**TLDR: View but cannot modify state.** A `view` function is one that does not mutate/modify the state of a contract but may read it. `view` functions can read contract state and call other `view` and pure functions. Example: `function x() public view returns (uint){//...}`.

`view` functions can call `pure` ones, but not the other way around. A `pure` function can be viewed as a `view` function.

Both of the last keywords cannot do the following:

-   modify or override state variables
-   create new contracts
-   invoke other functions that are not `pure` or `view`
-   emit events
-   use self-destruct
-   use low-level calls
-   send or receive Ethereum

## Sending And Receiving Eth

Solidity provides built-in keywords that make working with amounts of Ether easier.

-   `wei`: the smallest unit of ether
-   `gwei`: equal to 1,000,000,000 wei or 109 wei
-   `ether` : equal to 1,000,000,000,000,000,000 wei or 10e18 wei
    Some keywords:
-   `receive() external payable {}`: Handles receiving Ethereum. Example: Having a `uint public received` variable and executing `received += msg.value;` inside the `receive()` function.
-   `fallback() external payable {}`: It is called anytime that no function can handle what was sent to the current smart contract. Sort of the last resort. Called when Ethereum is sent to the contract and `msg.data` is not empty, when a function that does not exist is called on the contract, and when the Ethereum is sent to the contract and the `receive` function is not defined.
-   **_The recommended way to send Ethereum_**: Use `<address payable>.call`. It forwards all of the gas along with whoever is receiving such Ethereum (makes it more flexible than other sending functions). Example:

```Solidity
function withdraw() public {
    address payable user = payable(msg.sender);
    (bool sent,) = user.call{value: address(this).balance}("");
}

```

-   Re-entrance attacks: An attacker may drain a smart contract by calling some withdraw function again and again. To address this, keep track of received calls of withdrawals with a `mapping`, set the value of `msg.sender` to 0, and then send the Ethereum. Example:

```Solidity
contract HelloWorld {
    mapping(address =› uint) received;

    function withdraw() external{
        uint value = received[msg.sender];
        received[msg.sender] = 0;
        payable(msg.sender).call{value: value}("");
    }

    receive() external payable {
        received[msg.sender] += msg.value;
    }

    fallback() external payable {
        received[msg.sender] += msg.value;
    }
```

-   Other concerns: Keep track of change owed after paying Ethereum since an attacker may want to make the pay execution fail. Should have a withdraw function that uses the changed owed `mapping`.

## Exceptions and Errors

Keywords:

### Require

`require` is a Solidity function that is used for error handling. If the condition passed to a require function returns false then the transaction will fail and the state of the contract will revert. `require` is typically used to check for preconditions that should be true before executing a block of code.

### Assert

`assert` is a Solidity function that is used for error handling. If the condition passed to an `assert` function returns false then the transaction will fail and the state of the contract will revert. `assert` is typically used to check for conditions that should never be false.

### Revert

`revert` is a Solidity function that when called causes a transaction to fail and the state of the contract to revert. `revert` is typically used as an alternative to `require` when you are dealing with complex logic.

## Constructors

A contract constructor is called one time when the contract is deployed. This constructor is used to initialize values or accept initial values required by the contract. Example:

```Solidity
contract Constructor {
    uint count;
    constructor (uint startingCount) {
        count = startingCount;
    }
}
```

## Self Destruct

-   The `selfdestruct` function removes a smart contract from the blockchain and sends the balance of that contract to a provided address. Takes in an address as a parameter: `selfdestruct(payable(<address variable>))`.
-   If a smart contract is dependent on a balance (`address(this).balance`), an attacker could self-destruct and send the balance back to the vulnerable contract. To fix this, make the contract dependent on a state variable and not balance.

## Events

Events are emitted by smart contracts and stored in transaction logs. Useful for transmitting information from a smart contract to the outside of the blockchain network. Clients sitting outside of the blockchain can query event data or listen for specific events to occur.

Example: `event name(params...,)` like `event Bid(address indexed bidder, uint value);` where indexed parameters (max of 3) are fields considered _topics_ that are used to search an event with. Non-indexed parameters are simply considered _data_ and can have as many as you want. You call them like so `emit eventName(params...);`.

## Gas Cost and Estimation

In the context of Ethereum, **gas** is a fee required to execute transactions or smart contracts. Gas is paid in Ether and is denoted in gwei.

-   **Gas Units**: Measure of computational effort. An integer value of how much work is required to execute specific operations.
-   **Gas Price**: Amount of Ethereum that we are willing to pay per unit of gas. Denoted in gwei. Gas price = base + tip. The base fee is determined by the volume of the Ethereum network. Miners do not collect it. The tip is the amount on top of the base fee to give to make transactions faster.
-   **Tx Fee**: Cost = Gas Units \* Gas Price. Refund = Tx Fee Sent - Cost.
-   **Gas Limit**: Max fee willing to pay for a specific operation. If the operation costs more than the limit, then the operation will not happen.
-   Tx Fee = Units \* (base + tip).
-   Sending too much gas (max fee) is fine but if I still need some of it for another transaction, then I cannot use it until I get my refund back.
-   Gas is set by the user who makes the transaction. A smart contract uses Gas Units.
-   Ethereum tries to keep it such `that all blocks only receive 8,000,000 gas (soft limit).
-   `gasleft()`: tells you how much gas is remaining in a transaction.

## Math and Arithmetic

-   To get 21.55, multiply 2155 by 100 and then split the number apart. There are libraries that do this for us already.
-   If overflows/underflows happen, the contract will revert (only newer compiler versions of Solidity do this). We can you use `assert` to check that calculation will not be an overflow/underflow.
-   SafeMath library was very popular in older versions of Solidity. Has functions like `.sub`, `.add`, and so on. To use it, you could import the library URL, and another way is seen in the **Libraries** section.
-   Scientific notation can be done as follows: `uint x = 2.999873e10;`.

## Time and Time Units

-   **Time Units**: there are various built-in time units. These units make it easier to work with time and timestamps. The following are the valid time units in Solidity: `seconds`, `minutes`, `hours`, `days`, and `weeks`.
-   **Unix Epoch**: The Unix epoch is the time 00:00:00 UTC on 1 January 1970.
-   `block.timestamp`: timestamp of when a block was created (added to the blockchain).

## Structs

A typed collection of fields that can be treated like a custom type. Structs are useful for grouping data together.
Example:

```Solidity
struct Book {
    string title;
    string author;
    uint book_id;
}
```

## Modifiers

A modifier is used to modify the behavior of a function, typically to check repetitive preconditions. Modifiers must include at least one `_`, which represents a call to the modified function. They can take parameters.
Example:

```Solidity
modifier onlyOwner {
    require(msg.sender == owner);
    _; // automatically calls the function that used this modifier
}
```

-   Can have multiple parameters like this: `modifier modifierName(uint value){}` and use it like this: `function functionName(uint num) public payable modifierName(uint value)`.
-   Can have multiple modifiers.
-   Multiple modifiers will be called in the order in which they are placed after a function.
-   Multiple `_`'s: Calls the function as many times as there are `_`'s.

## Enums

They are a type that allows you to restrict a variable to a predefined list of values. Each value in an `enum` is encoded with a `uint` value starting from `0`.
Example:

```Solidity
enum Sizes = {
    SMALL, // 0
    MEDIUM, // 1
    LARGE, // 2
}
```

## Inheritance

Refers to when a contract derives/uses the functionality from another contract. Inheritance is a way of reusing/extending functionality. Many of the OOP's inheritance principles are in Solidity like function overriding, function overloading, the `super` keyword, and inheritance with constructors. and method resolution order.

-   To override function: Add `virtual` to the function after the access modifier in the parent contract, and `override` to the same function in the child contract.
-   To overload function: No need to use `override`, can simply add additional parameters to inherited function.
-   `super`: reference methods and variables in base contract.
-   Multiple inheritance: `contract Child is A, B {}`
-   Method resolution order: If multiple contracts have the same method name, and a child contract inherits from them and uses `contract Child is A, B {}`, then we look from right to left to resolve same name conflicts. So B's method would be considered first, then A, and so on. This method should use `override(A,B)`.
-   Example:

```Solidity
contract Item{
    uint price;

    constructor(uint _price){
        price = _price;
    }

    function getPrice() public view returns(uint) {
        return price;
    }
}

contract Milk is Item(5) {
    enum Type {
        OnePercent, TwoPercent
    }
    Type milkType;
    uint litres;

    constructor(Type _milkType, uint _litres){
        milkType = _milkType;
        litres = _litres;
    }
}

constructor Shopping {
    Item[] items;

    function addMilk(Type _type, uint litres) public {
        Milk milk = new Milk(_type, litres);
        items.push(milk);
    }

    function getTotalPrice() public view returns (uint){
        uint price;
        for(uint idx; idx < items.length; idx++){
            price = items[idx].getPrice();
        }
        return price;
    }
}
```

## Abstract Contracts

Only used as a base/parent contract and cannot be instantiated. It typically contains at least one abstract function (i.e., a function marked as `virtual`). Declare like this: `abstract contract ContractName {}`. It can have concrete functions AND abstract functions.

## Interfaces

**Interfaces** are used to declare the functionality that deriving/implementing contracts must override. Interfaces are used to view different contracts through the same type. They have the following properties:

-   May not have any function with implementation.
-   All defined functions must be marked as `external`.
-   May not have a constructor.
-   May not have state variables.
-   May define enums and structs.
-   Example:

```Solidity
interface Numeric {
    function add(uint x) external returns (uint);
    function subtract(uint x) external returns (uint);
}
```

## Libraries

They are a collection of reusable utility functions. Libraries contain functions that are called by other contracts and can be deployed independently to save on gas and avoid repeated code.

-   They cannot inherit any elements or be inherited from them.
-   They are stateless. The functions inside the library can only be `view` or `pure`.
-   Can not be destroyed using `selfdestruct()` since it cannot have state variables.
-   Calling its functions is free (does not cost any gas).
-   There are no fallback or payable functions implemented in libraries.
-   You can define enums and structs.
-   Example:

```Solidity
library Math {
    function pow(uint a, uint b) public view returns (uint) {
        return a**b;
    }
}
```

## Contract Storage

Different kinds of storage locations in smart contracts:

### Storage

`storage` is a persistent location where data associated with a smart contract is held. Storage variable data is stored on the blockchain and is very expensive to read and write from.

-   Permanent/Persistent location
-   Stored on the blockchain
-   Expensive to write to
-   Free to read externally
-   Can only be modified by the contract that holds the values
-   Contains 2^256 slots
-   Each storage slot can hold 32 bytes
-   Storage slots can store multiple values/variables

### Memory

`memory` is a temporary, mutable storage location that is typically used for holding reference data types. `memory` is a cheaper storage location than contract storage.

-   Temporary location
-   Stored in RAM
-   Cheaper to write to
-   Mutable
-   Typically used for reference types, like: **structs**, **arrays**, **strings**, **bytes**.
-   Cleared after function execution
-   Memory -> Memory = Reference (assigning a memory type to another creates a reference)
-   Memory -> Storage = Copy
-   Storage -> Memory = Copy
-   Storage -> Storage = Reference

### Calldata

`calldata` is a read-only, non-persistent storage location that is used for function parameters. It behaves similarly to memory but it cannot be modified.

-   Temporary location
-   Only stores function arguments
-   Behaves similarly to memory
-   Can be cheaper than memory
-   Immutable
-   Useful for ensuring no unintended copies are made

### Stack

In the EVM/Solidity context, the stack is a temporary internal storage location where variables are stored in 32-byte slots. It is used for small local variables and the value types of functions (i.e., the type of parameters and return values).

-   Temporary location
-   Internal location, not directly accessible (requires assembly)
-   Used for small local variables
-   Stores function value types (`uint`, `int`, `string`, etc.)
-   Can hold up to 1024 values

### Logs

Ethereum smart contracts can emit events, these events are stored in transaction receipts in a special area known as **logs**. Logs give you information about what happened during smart contract execution.

-   Associated with transactions
-   Cannot be accessed by smart contracts
-   Where event data is stored
-   Cheap data structure
-   Useful for returning information to the caller of a function
-   Accessed off the blockchain

### Code

The code itself could be considered storage.

-   The actual code of the contract
-   Stored on the blockchain
-   Constant variables stored here

## Optimizing Gas Costs

Poorly optimized smart contracts can quickly become voracious gas consumers. Here are some tricks you can use to keep your smart contracts in check and make them less gassy:

-   Use `calldata` because it is cheaper than `memory` and if you just want to see variables' values, but it is limiting because you cannot modify those variables.
-   Pack variables: Slot's sizes are 256 bits. Create variables in order of `uint` size in order to have fewer slots (pack variables).
-   Delete unused variables: Whenever you free space in a contract, use `delete` instead of manually resetting the values yourself.
-   Don't shrink variables: If there is no specific need to use a smaller variable value than the default value, then do it. Only shrink if you are packing variables together.
-   If you can emit an event instead of storing that information in the contract, then do so, unless such data has to be private/secure.
-   Use libraries. If a good amount of contracts have the same logic, such logic can be put in a library and be reused in the contracts.
-   Use short-circuiting rules: If there's no need to bother to check all the sides of a boolean expression, then put the most important one in front such that a boolean expression can finish faster. If you have `true || false`, then the compiler only evaluates `true` since it already satisfies the `||` logic.
-   Avoid assignments: If you do not have to do an assignment like default values, then don't do them. (`uint x;` better than `uint x = 0;`)
-   Avoid operations on storage. Instead, you can cache the original variable, update the caching variable, and then assign the cached value to the original variable.
-   A fixed-sized array is cheaper to store than a dynamic-sized array.
-   Mappings are cheaper than arrays.
-   Using `bytes` type is cheaper than `string`.
-   Use `external` over `public` modifier. `public` means that a function can be called in the same contract as well as externally. If this is the case, the compiler does more work and uses more gas. If a function is simply just called externally, use `external`.
