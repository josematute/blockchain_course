pragma solidity >=0.7.0 <0.9.0;

contract Contract {
    uint256 x;

    function add(uint256 value) public {
        x += value;
    }
}