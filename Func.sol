// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract FunctionIntro{
    // pure 不会修改区块链
    function add(uint x, uint y) external pure  returns (uint) {
        return x + y;
    }

    function sub(uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}