// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract StateVariables {
    uint public myUint = 123;

    function foo() external {
        uint x = myUint;
    }
}