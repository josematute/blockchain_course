// showcase of events, count increases counter by 1 and emits an event

pragma solidity >=0.4.22 <=0.8.17;

contract EventEmitter {
    uint8 counter = 0;
    address owner;

    event Called(uint8 count, address sender);

    constructor(){
        owner = msg.sender;
    }

    function count() public{
        counter += 1;
        emit Called(counter, owner);
    }
}
