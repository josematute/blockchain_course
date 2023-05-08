pragma solidity >=0.4.22 <=0.8.17;

/*
Write a smart contract named AdvancedCounter that allows multiple users to keep track of their own independent counters. Each 
counter will be represented by a string id and will be specific to each user/account that interacts with the smart contract. 
Each user should have a limit of 3 counters. Each counter should store an int value. For example, account with address oxabc...
may have three counters with ids "a", "b", "c". Each counter should be able to be manipulated independently of all other counters 
by using the functions below. To clarify, if another address, say Oxbbb. had a counter with id "a" this would be a separate counter 
from the counter with id "a" that is controlled by oxabc.. Each address should only be able to control their own counters.
*/
contract AdvancedCounter {
    mapping(address => mapping(string => int256)) counters;
    mapping(address => mapping(string => bool)) counterIdExists; // required to keep track of used ids
    mapping(address => uint256) numCountersCreated; // requireed to keep track of number of counters

    function counterExists(string memory id) internal view returns (bool) {
        return counterIdExists[msg.sender][id];
    }

    function createCounter(string memory id, int256 value) public {
        require(numCountersCreated[msg.sender] != 3, "you have already created the maximum number of counters");
        require(!counterExists(id), "a counter with this id already exists");
        counters[msg.sender][id] = value;
        numCountersCreated[msg.sender]++;
        counterIdExists[msg.sender][id] = true;
    }

    function deleteCounter(string memory id) public {
        require(counterExists(id), "this counter does not exist");
        delete counters[msg.sender][id];
        numCountersCreated[msg.sender]--;
        counterIdExists[msg.sender][id] = false;
    }

    function incrementCounter(string memory id) public {
        require(counterExists(id), "this counter does not exist");
        counters[msg.sender][id]++;
    }

    function decrementCounter(string memory id) public {
        require(counterExists(id), "this counter does not exist");
        counters[msg.sender][id]--;
    }

    function getCount(string memory id) public view returns (int256) {
        require(counterExists(id), "this counter does not exist");
        return counters[msg.sender][id];
    }
}
