pragma solidity >=0.4.22 <=0.8.17;

// Abstract contract
/*
For this question you'll be asked to write a set of contracts that will allow you to track the winning teams across multiple types of games.
Start by writing an abstract contract named Game that will implement the base functionality for all games. This contract should be initialized 
by passing the string homeTeam and the string awayTeam. It should also include the following functions.
- getHomeTeamScore() : an abstract internal function that returns the uint score of the home team. This function should be overridden by any 
child contracts. 
- getAwayTeamScore() : an abstract internal function that returns the uint score of the away team. This function should 
be overridden by any child contracts.
- getwinningTeam(): a public concrete function that returns the string name of the winning team for this game.

After completing this contract write the following two children contracts named BasketballGame and SoccerGame that inherit from Game
The BasketballGame contract should override the necessary functions from Game and implement the following additional functions.
- homeTeamScored(uint score): this external function should increment the home teams score by the passed score. The only valid scores are 
1, 2 and 3, the function should fail if you pass an invalid score.
- awayTeamScored(uint score) this external function should increment the away teams score by the passed score. The only valid scores are 1, 
2 and 3, the function should fail if you pass an invalid score
The SoccerGame contract should override the necessary functions from Game and implement the following additional functions.
- homeTeamScored() : this external function should increment the home teams score by one. 
- awayTeamScored(): this external function should increment the away teams score by one.
*/

abstract contract Game {
    string homeTeam;
    string awayTeam;

    constructor(string memory _homeTeam, string memory _awayTeam) {
        homeTeam = _homeTeam;
        awayTeam = _awayTeam;
    }

    function getHomeTeamScore() internal view virtual returns (uint256);

    function getAwayTeamScore() internal view virtual returns (uint256);

    function getWinningTeam() public view returns (string memory) {
        if (getHomeTeamScore() > getAwayTeamScore()) {
            return homeTeam;
        } else {
            return awayTeam;
        }
    }
}

contract BasketballGame is Game {
    uint256 homeTeamScore;
    uint256 awayTeamScore;

    constructor(string memory _homeTeam, string memory _awayTeam)
        Game(_homeTeam, _awayTeam)
    {}

    modifier validScore(uint256 score) {
        require(score > 0 && score < 4, "invalid score");
        _;
    }

    function getHomeTeamScore() internal view override returns (uint256) {
        return homeTeamScore;
    }

    function getAwayTeamScore() internal view override returns (uint256) {
        return awayTeamScore;
    }

    function homeTeamScored(uint256 score) external validScore(score) {
        homeTeamScore += score;
    }

    function awayTeamScored(uint256 score) external validScore(score) {
        awayTeamScore += score;
    }
}

contract SoccerGame is Game {
    uint256 homeTeamScore;
    uint256 awayTeamScore;

    constructor(string memory _homeTeam, string memory _awayTeam)
        Game(_homeTeam, _awayTeam)
    {}

    function getHomeTeamScore() internal view override returns (uint256) {
        return homeTeamScore;
    }

    function getAwayTeamScore() internal view override returns (uint256) {
        return awayTeamScore;
    }

    function homeTeamScored() external {
        homeTeamScore++;
    }

    function awayTeamScored() external {
        awayTeamScore++;
    }
}
