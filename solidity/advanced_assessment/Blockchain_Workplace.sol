pragma solidity >=0.4.22 <=0.8.17;

// Inheritance
/*
This is a smart contract named Employee and a smart contract that inherits from Employee named Manager . Managers share all the properties of 
employees but have subordinates which may be other managers or employees. Each Employee instance is initialized (using the constructor) by 
passing a string firstName, string lastName, uint hourlyPay and a uint department, in this order. Use an enum to represent the valid departments 
of Gardening, Clothing and Tools, in that order. Each Manager instance is initialized the same as an employee.
The Employee contract should implement the following functions.
• getWeeklyPay(uint hoursWorked) : returns a uint representing the amount this employee should be paid based on their hourly rate and the hours 
worked. This function should factor in overtime pav. For every hour bevhond 40 that the emplovee works they should be paid double their hourly rate. 
For example, if an emplovee makes $20/hour and works 42 hours they are paid $880.
• getFirstName() : returns a string representing the first name of the employee.
The Manager contract should implement the following functions.
• addSubordinate(string firstName, string lastName, uint hourlyPay, Department department) : this function takes the required arguments to create a new
employee and adds this employee to this managers subordinates.
• getSubordinates() : this function should return a string[] containing the first names of all of its subordinates.
Note: you do not need to handle any edge cases like managers having duplicate subordinates.
*/
contract Employee {
    enum Department {
        Gardening,
        Clothing,
        Tools
    }

    string firstName;
    string lastName;
    uint256 hourlyPay;
    Department department;

    constructor(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) {
        firstName = _firstName;
        lastName = _lastName;
        hourlyPay = _hourlyPay;
        department = _department;
    }

    function getWeeklyPay(uint256 hoursWorked) public view returns (uint256) {
        if (hoursWorked <= 40) {
            return hourlyPay * hoursWorked;
        }
        uint256 overtimeHours = hoursWorked - 40;
        return 40 * hourlyPay + (overtimeHours * 2 * hourlyPay);
    }

    function getFirstName() public view returns (string memory) {
        return firstName;
    }
}

contract Manager is Employee {
    Employee[] subordinates;

    constructor(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) Employee(_firstName, _lastName, _hourlyPay, _department) {}

    function addSubordinate(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) public {
        Employee employee = new Employee(
            _firstName,
            _lastName,
            _hourlyPay,
            _department
        );
        subordinates.push(employee);
    }

    function getSubordinates() public view returns (string[] memory) {
        string[] memory names = new string[](subordinates.length);
        for (uint256 idx; idx < subordinates.length; idx++) {
            names[idx] = subordinates[idx].getFirstName();
        }
        return names;
    }
}