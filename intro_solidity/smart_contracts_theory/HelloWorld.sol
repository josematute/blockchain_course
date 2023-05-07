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