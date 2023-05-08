pragma solidity >=0.4.22 <=0.8.17;

/*
Write a smart contract named EtherElection that allows users to vote for the "Ether King". This smart contract will 
go through three main phases, namely, candidate enrollment, voting and rewards/payouts. During the first phase users 
that wish to run for election will need to submit exactly 1 Ethereum. Once three users have enrolled as candidates the 
enrollment phase will end and the voting phase will start. During the voting phase users will be able to submit a vote 
for one of the three candidates. Users that wish to vote will have to pay a fee of exactly 10, 000 wei. This fee will 
be non-refundable and held in the balance of the smart contract. Once any candidate receives exactly 5 votes they will 
be declared the winner and the voting phase will end. In the final phase (once the winner has been declared) the winner 
will be able to withdraw 3 Ethereum from the contract as their prize for winning. Once the winner has withdrawn their 
prize the contract can be destroyed by the owner/deployer who should collect all of the fees paid by voters.*/
contract EtherElection {
    address owner;

    address[] candidates;
    mapping(address => uint256) votes;
    mapping(address => bool) voted;

    address winner;
    bool winnerWithdrew;

    constructor() {
        owner = msg.sender;
    }

    function isCandidateInCandidates(address candidate) internal view returns (bool) {
        for(uint256 idx; idx < candidates.length; idx++){
            address currentCandidate = candidates[idx];
            if(currentCandidate == candidate){
                return true;
            }
        }
        return false;
    }

    function enroll() public payable {
        require(candidates.length != 3, "3 candidates have already enrolled");
        require(msg.value == 1 ether, "you must send exactly one ether");
        require(!isCandidateInCandidates(msg.sender), "you are already a candidate");
        candidates.push(msg.sender);
    }

    function vote(address candidate) public payable {
        require(candidates.length == 3, "enrollment is not done");
        require(isCandidateInCandidates(candidate), "invalid candidate");
        require(winner == address(0), "voting has ended");
        require(!voted[msg.sender], "you have already voted");
        require(msg.value == 10000, "incorrect fee");
        voted[msg.sender] = true;
        votes[candidate]++;

        if(votes[candidate] == 5){
            winner = candidate;
        }
    }

    function getWinner() public view returns (address) {
        require(winner != address(0), "winner has not been declared");
        return winner;
    }

    function claimReward() public {
        require(winner != address(0), "winner has not been declared");
        require(msg.sender == winner, "you are not the winner");
        require(!winnerWithdrew, "eyou have already withdrawn your reward");
        winnerWithdrew = true;
        (bool sent, ) = payable(winner).call{value: 3 ether}("");
        require(sent, "transfer failed");
    }

    function collectFees() public {
        require(winnerWithdrew, "winner has not yet withdrawn reward");
        require(msg.sender == owner, "only the onwer can call this function");
        selfdestruct(payable(owner));
    }
}
