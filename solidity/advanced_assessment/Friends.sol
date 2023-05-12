pragma solidity >=0.4.22 <=0.8.17;

// Structs and modifiers

/*
Write a smart contract named Friends that allows users to send and accept friend requests. The following are rules this smart contract should adhere to.
• A user cannot cannot send more than one friend request to the same address.
• A user cannot send a friend request to a user that has sent them a friend request.
• A user cannot send a friend request to a user they are already friends with.
• A user cannot accept a friend request that doesn't exist or that they have already accepted.
• A user cannot send a friend request to themselves.
This contract uses advanced solidity features like modifiers and structs when implementing the functions defined below.
- getFriendRequests () : returns address [] containing the addresses of users that have sent this user a request that they have yet to accept 
(i.e., don't return accepted requests).
- getNumberOfFriends () : returns a uint value representing the number of friends the calling user has.
- getFriends () : returns address [] containing the addresses of the calling users friends.
- sendFriendRequest (address friend): sends a friend request to the provided address
- acceptFriendRequest (address friend) : accepts a pending friend request.
*/

contract Friends {
    struct Person {
        address[] friends;
        address[] requestsSent;
        address[] requestsReceived;
    }

    mapping(address => Person) people;

    function arrayContains(address[] memory array, address target)
        internal
        pure
        returns (bool)
    {
        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                return true;
            }
        }
        return false;
    }

    function deleteFromArray(address[] storage array, address target) internal {
        uint256 targetIdx;
        for (uint256 idx; idx < array.length; idx++) {
            if (array[idx] == target) {
                targetIdx = idx;
                break;
            }
        }

        uint256 lastIdx = array.length - 1;
        address lastValue = array[lastIdx];
        array[lastIdx] = target;
        array[targetIdx] = lastValue;
        array.pop();
    }

    modifier requestNotSent(address friend) {
        address[] memory requestsSent = people[msg.sender].requestsSent;
        require(
            !arrayContains(requestsSent, friend),
            "you have already sent this user a request"
        );
        _;
    }

    modifier requestNotReceived(address friend) {
        address[] memory requestsReceived = people[msg.sender].requestsReceived;
        require(
            !arrayContains(requestsReceived, friend),
            "this user has already sent you a request"
        );
        _;
    }

    modifier requestExists(address friend) {
        address[] memory requestsReceived = people[msg.sender].requestsReceived;
        require(
            arrayContains(requestsReceived, friend),
            "this user has not sent you a request"
        );
        _;
    }

    modifier notAlreadyFriends(address friend) {
        address[] memory friends = people[msg.sender].friends;
        require(
            !arrayContains(friends, friend),
            "you are already friends with this user"
        );
        _;
    }

    modifier notSelf(address friend) {
        require(
            friend != msg.sender,
            "you cannot send a friend request to yourself"
        );
        _;
    }

    function getFriendRequests() public view returns (address[] memory) {
        return people[msg.sender].requestsReceived;
    }

    function getNumberOfFriends() public view returns (uint256) {
        return people[msg.sender].friends.length;
    }

    function sendFriendRequest(address friend)
        public
        requestNotSent(friend)
        requestNotReceived(friend)
        notAlreadyFriends(friend)
        notSelf(friend)
    {
        people[msg.sender].requestsSent.push(friend);
        people[friend].requestsReceived.push(msg.sender);
    }

    function acceptFriendRequest(address friend) public requestExists(friend) {
        deleteFromArray(people[msg.sender].requestsReceived, friend);
        deleteFromArray(people[friend].requestsSent, msg.sender);
        people[msg.sender].friends.push(friend);
        people[friend].friends.push(msg.sender);
    }

    function getFriends() public view returns (address[] memory) {
        return people[msg.sender].friends;
    }
}
