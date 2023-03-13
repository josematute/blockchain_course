// keeps track of the user who has sent the most ether to the contract.
// every time a new use becomes the 'richest', the Eth send by the prev richest user should
// be refunded to that user. The withdrawl pattern is implemented to avoid re-entrance attacks.
pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
   address richest;
   uint mostSent;
   mapping(address => uint256) pendingWithdrawls;

   function becomeRichest() external payable returns (bool) {
       if(msg.value <= mostSent){
          return false;
       }
       pendingWithdrawls[richest] += mostSent;
       richest = msg.sender;
       mostSent = msg.value;
       return true;
   }

   function withdraw() external {
      uint amount = pendingWithdrawls[msg.sender];
      // important to do this before transferring funds to avoid Re-entrance attacks
      pendingWithdrawls[msg.sender] = 0;
      // 'consensus' correct way to send Ethereum
      (bool sent, ) = payable(msg.sender).call{value: amount}("");
      require(sent);
   }

   function getRichest() public view returns (address){
      return richest;
   }
}
