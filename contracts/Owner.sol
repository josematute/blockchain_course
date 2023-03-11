// showcase of the constructor, smart contract wont let anyone who is not the owner to call functions

pragma solidity >=0.4.22 <=0.8.17;

contract OnlyOwner {
    uint8 state_var;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function add(uint8 number) public {
        require(msg.sender == owner, "you are not the owner lol...");
        state_var += number;
    }

    function subtract(uint8 number) public {
        require(msg.sender == owner, "you are not the owner lol...");
        state_var -= number;
    } 

    function get() public view returns (uint8) {
        require(msg.sender == owner, "you are not the owner lol...");
        return state_var;
    }
}
