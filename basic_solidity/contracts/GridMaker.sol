// showcase of Solidity loops

pragma solidity >=0.4.22 <=0.8.17;

contract GridMaker {
    function make2DIntGrid(
        uint256 rows,
        uint256 cols,
        int256 value
    ) public pure returns (int256[][] memory) {
        int256[][] memory arr = new int256[][](rows);
        for(uint i; i < rows; i++){
            int256[] memory nestedArr = new int256[](cols);
            for(uint j; j < cols; j++){
                nestedArr[j] = value;
            }
            arr[i] = nestedArr;
        }
        return arr;
    }

    function make2DAddressGrid(uint256 rows, uint256 cols)
        public
        view
        returns (address[][] memory)
    {
        address[][] memory arr = new address[][](rows);
        for(uint i; i < rows; i++){
            address[] memory nestedArr = new address[](cols);
            for(uint j; j < cols; j++){
                nestedArr[j] = msg.sender;
            }
            arr[i] = nestedArr;
        }
        return arr;
    }
}
