# Solidity Fundamentals

Solidity is a high-level, statically-typed, object-oriented programming language designed explicitly to implement smart contracts on blockchain platforms, notably Ethereum. It enables developers to create decentralized applications (dApps) by encoding rules, functions, and state transitions of contracts. Solidity's code is compiled into bytecode, and executed on the Ethereum Virtual Machine (EVM) to facilitate secure, transparent, and trustless interactions between parties. As the primary language for Ethereum development, Solidity has become crucial in the blockchain ecosystem and has contributed significantly to the rise of decentralized finance (DeFi), tokenization, and other innovative applications.

The following are most of the fundamentals on Solidity to reference at any time.

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
