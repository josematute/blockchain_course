// showcase of Solidity arrays and their functions

pragma solidity >=0.4.22 <=0.8.17;

contract Following {
    mapping(address => address[]) following;

    function follow(address toFollow) public {
        require(following[msg.sender].length < 3, 
        "msg.sender already follows maximum amount");
        require(toFollow != msg.sender, 
        "msg.sender cannot follow itself");
        following[msg.sender].push(toFollow);
    }

    function getFollowing(address addr) public view returns (address[] memory) {
        return following[addr];
    }

    function clearFollowing() public {
        delete following[msg.sender];
    }
}
