// smart contract that keeps track of the amount of ETH received from any address that sends
// ETH to the contract.

pragma solidity >=0.4.22 <=0.8.17;

contract Balances {
    mapping(address => uint) balances;

    function getAmountSent(address addr) public view returns (uint){
        return balances[addr];
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    fallback() external payable {
        balances[msg.sender] += msg.value;
    }
}
