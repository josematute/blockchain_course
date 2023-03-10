pragma solidity >=0.4.22 <=0.8.17;

contract DebtTracking {
    mapping(address => mapping(address => uint)) owing;

    function addDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        owing[toBePaidAddress][payingAddress] += amount;
    }

    function payDebt(
        address toBePaidAddress,
        address payingAddress,
        uint256 amount
    ) public {
        uint256 owed = owing[toBePaidAddress][payingAddress];
        if(amount > owed){
            uint256 change = amount - owed;
            owing[toBePaidAddress][payingAddress] = 0;
            owing[payingAddress][toBePaidAddress] += change;
        } else {
            owing[toBePaidAddress][payingAddress] -= amount;
        }
    }

    function getDebt(address toBePaidAddress, address payingAddress)
        public
        view
        returns (uint256)
    {
        return owing[toBePaidAddress][payingAddress];
    }
}
