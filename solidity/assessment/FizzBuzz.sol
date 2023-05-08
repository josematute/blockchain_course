
pragma solidity >=0.4.22 <=0.8.17;

/*
Write a smart contract named FizzBuzz that implements the famous Fizz Buzz algorithm, but with a twist. 
Rather than returning strings "Fizz" and "Buzz" you'll emit events. The FizzBuzz problems is a famous 
algorithm style coding question where you are tasked to iterate through a sequence of integers and print 
"Fizz" if the integer is divisible by 3 , "Buzz" if divisible by 5 and "FizzBuzz" if the integer is 
divisible by both 3 and 5. For this question your contract will need to keep track of a count and emit 
custom events each time the count is changed.
*/
contract FizzBuzz {
    uint256 count;

    event Fizz(address sender, uint256 indexed count);
    event Buzz(address sender, uint256 indexed count);
    event FizzAndBuzz(address sender, uint256 indexed count);

    function increment() public {
        count++;

        bool divBy3 = count % 3 == 0;
        bool divBy5 = count % 5 == 0;

        if(divBy3 && divBy5){
            emit FizzAndBuzz(msg.sender, count);
        } else if (divBy3){
            emit Fizz(msg.sender, count);
        } else if (divBy5){
            emit Buzz(msg.sender, count);
        }
    }
}
