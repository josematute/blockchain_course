// Copyright © 2023 AlgoExpert LLC. All rights reserved.
/*
Keeps track of the user who has sent the most ether to the contract. Every time a new user becomes the "richest",
the Ethereum sent by the previous richest user should be refunded to that user. When the contract is first deployed 
the richest user should be the zero address. The withdrawl pattern is implemented such that no re-entrance attack is 
possible. This smart contract has the following functionality:
•becomeRichest: a function that accepts ether and updates the richest user if they have sent more Ethereum than the 
previous richest user. This function should return true if the user successfully became the richest, otherwise it 
should return false . If a user sends Ethereum to this function and does not become the richest they should not be 
refunded their Ethereum or be able to withdraw it.
• withdraw: a function that allows users who were previously the richest to withdraw their funds. The current richest 
user should not be able to withdraw any funds. It protects against re-entrance attacks.
•getRichest: a function that returns the address of the current richest user. 

 This example is a variation of the WithdrawlContract shown in the official Solidity documentation.
*/

pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
    address richest;
    uint256 mostSent;
    mapping(address => uint256) pendingWithdrawls;

    function becomeRichest() external payable returns (bool) {
        if (msg.value <= mostSent) {
            return false;
        }

        pendingWithdrawls[richest] += mostSent;
        richest = msg.sender;
        mostSent = msg.value;
        return true;
    }

    function withdraw() external {
        uint256 amount = pendingWithdrawls[msg.sender];
        pendingWithdrawls[msg.sender] = 0; // important to do this before transferring the funds to avoid reentrance
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent);
    }

    function getRichest() public view returns (address) {
        return richest;
    }
}
