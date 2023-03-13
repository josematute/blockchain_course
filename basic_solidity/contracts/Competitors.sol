// showcase of selfdestruct(), contract that onyl allows two addresses to send ETH contracts. 
// Once one gets to 3 ETH, gets to withdraw 3 ETH

pragma solidity >=0.4.22 <=0.8.17;

contract Competitors {
    address owner;
    address depositor1;
    address depositor2;
    address maxDepositor;
    address winner;
    uint depositor1Deposited;
    uint depositor2Deposited;
    bool withdrew;

    constructor(){
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value == 1 ether, "you need to send 1 ETH");
        require(depositor1Deposited + depositor2Deposited < 3 ether, 
        "3 ETH has been received, no more deposits are accepted");
        
        if (depositor1 == address(0)){
            depositor1 = msg.sender;
        } else if (depositor2 == address(0)) {
            depositor2 = msg.sender;
        }

        if(msg.sender == depositor1){
            depositor1Deposited += msg.value;
        } else if (msg.sender == depositor2){
            depositor2Deposited += msg.value;
        } else{
            revert("u r not a valid depositor");
        }

        if(depositor1Deposited + depositor2Deposited >= 3 ether){
            if(depositor1Deposited > depositor2Deposited){
                maxDepositor = depositor1;
            } else {
                maxDepositor = depositor2;
            }
        }
    }

    function withdraw() external {
        require(depositor1Deposited + depositor2Deposited >= 3 ether, 
        "3 ETH has not yet been received");
        require(msg.sender == maxDepositor, "you did not deposit the most ether");
        payable(maxDepositor).call{value: 3 ether}("");
        withdrew = true;
    }

    function destroy() external {
        require(msg.sender == owner, "u r not owner");
        require(withdrew == true, "max depositor has not yet withdrew their funds");
        selfdestruct(payable(owner));
    }
}
