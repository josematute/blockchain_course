pragma solidity >=0.4.22 <=0.8.17;

/*
Write a smart contract named GreedyBanker that acts as a bank account for users. It should allow users to deposit 
funds by sending ether directly to the contract address via the receive function and to withdraw their funds using 
a function you'll implement named withdraw. The catch is, the deployer of this smart contract is greedy and wants 
to collect a fee from users when they make a deposit. Each address that deposits to the smart contract should get 
exactly one free deposit, afterwards a fee of 1000 wei should be charged for each deposit. The fees collected by 
this smart contract should be stored such that the owner can withdraw/collect them at their convenience. If a user 
has used up their free deposit and attempts to send less money than 1000 wei (the fee) their deposit should fail. 
All of this logic should be handled in the receive function. If a user incorrectly sends funds (i.e., the transaction 
triggers the fallback function), all the funds received should be added to the current fees collected and become 
withdrawable by the owner/deployer of the contract.*/
contract GreedyBanker {
    uint256 constant fee = 1000 wei;
    mapping(address => uint256) balances;
    mapping(address => uint256) depositCount;
    uint256 feesCollected;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        uint256 depositFee;
        if (depositCount[msg.sender] >= 1){
            require(msg.value >= fee, "amount is not enough to cover the fee");
            depositFee = fee;
        }
        balances[msg.sender] += msg.value - depositFee;
        feesCollected += depositFee;
        depositCount[msg.sender]++;
    }

    fallback() external payable {
        feesCollected += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient balance");
        balances[msg.sender] -= amount;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "withdraw failed");
    }

    function collectFees() external {
        require(msg.sender == owner, "only owner can call this function");
        uint256 totalFees = feesCollected;
        feesCollected = 0;
        (bool sent, ) = payable(owner).call{value: totalFees}("");
        require(sent, "transfer failed");
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
