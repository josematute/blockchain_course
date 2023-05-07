# Solidity Fundamentals

Solidity is a high-level, statically-typed, object-oriented programming language designed explicitly to implement smart contracts on blockchain platforms, notably Ethereum. It enables developers to create decentralized applications (dApps) by encoding rules, functions, and state transitions of contracts. Solidity's code is compiled into bytecode, and executed on the Ethereum Virtual Machine (EVM) to facilitate secure, transparent, and trustless interactions between parties. As the primary language for Ethereum development, Solidity has become crucial in the blockchain ecosystem and has contributed significantly to the rise of decentralized finance (DeFi), tokenization, and other innovative applications.

The following are most of the fundamentals on Solidity for anybody to reference at any time.

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

## Operators & Type Conversions

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

## Mappings

In Solidity, the reference data type known as `mapping` allows you to store key-value pairs. Mappings can only be stored in contract storage and are useful for quickly accessing
associated data.

-   Every single key will return some value and if the key does not exist, it will return the default value from such data type. Cannot access the keys, so a common workaround is to have an auxiliary data structure that stores them.
-   Can have nested mappings
-   For this type, it has to be stored somewhere other than the stack (rule from Solidity).
-   If needed to be used inside a function, use `storage` keyword and copy an _original_ map created in the state of the contract (which makes it a reference to the _original_ map). Very limited to be used inside a function.
-   To pass in as a parameter, function declaration should look like: `function x(mapping(unit => unit) storage map) internal { ... }`.
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

## Functions And Access Modifiers

-   Return multiple values like so: `return (1, 1, 1);`

### Public

`public` is a visibility modifier that can be used to mark variables and functions as accessible from within or outside of the contract. Any variable or function marked as public can be accessed from any location.

### Private

the `private` visibility modifier is used to mark a function or variable as only accessible from within the contract it is defined in. Private functions and variables cannot be accessed from any derived contracts, outside the blockchain or any location other than the contract they are defined in. **_Note: Although private variables cannot be accessed from outside of a contract, their data can still be found and read on the blockchain. This is because the blockchain is publicly available and anybody can view and verify all of the data on the blockchain._**

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
-   use low level calls
-   send or receive ethereum
