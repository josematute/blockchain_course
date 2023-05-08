// Copyright © 2023 AlgoExpert LLC. All rights reserved.
/*
Receiving Ethereum
This contract tracks the amount of ether received from any address that sends ether to the contract. 
To do this, it implements both a receive and fallback function as well as a getAmountSent function. The
getAmountSent (address addr) : returns the amount of ether in wei that addr has sent to the contract.
*/

pragma solidity >=0.4.22 <=0.8.17;

contract Balances {
    mapping(address => uint256) balances;

    fallback() external payable {
        balances[msg.sender] += msg.value;
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    function getAmountSent(address addr) public view returns (uint256) {
        return balances[addr];
    }
}