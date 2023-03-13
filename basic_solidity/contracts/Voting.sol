// example on exception and errors: revert, assert and require

pragma solidity >=0.4.22 <=0.8.17;

contract Voting {
    mapping(uint8 => uint8) votes;
    mapping(address => bool) voteTracker;
    uint8 currentWinner;
    uint8 mostVotes;

    function getVotes(uint8 number) public view returns(uint){
        require(number >= 1 && number <=5, "number is not in the range of 1-5");
        return votes[number];
    }

    function vote(uint8 number) public {
        require(!voteTracker[msg.sender], "user has already voted");
        require(number >= 1 && number <= 5, "number is not in the range of 1-5");
        voteTracker[msg.sender] = true;
        votes[number] += 1;

        if(votes[number] >= mostVotes){
            currentWinner = number;
            mostVotes = votes[number];
        }
    }

    function getCurrentWinner() public view returns (uint8){
        if(currentWinner == 0){
            return 1;
        }
        return currentWinner;
    }
}
