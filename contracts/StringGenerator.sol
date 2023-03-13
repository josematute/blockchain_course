// showcase of Solidity strings and how bytes are a better alternative

pragma solidity >=0.4.22 <=0.8.17;

contract StringGenerator {
    mapping(address => bool) users;
    bytes public str;

    function addCharacter(string memory character) public {
        require(users[msg.sender] == false, "user already addes string");
        require(str.length < 5, "str is already of length 5");
        require(bytes(character).length == 1, "character needs to be len 1");
        bytes memory convertedChar = bytes(character);
        users[msg.sender] = true;
        str.push(convertedChar[0]);
    }

    function getString() public view returns (string memory) {
        return string(str);
    }
}
