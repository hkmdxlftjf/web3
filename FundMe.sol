// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FuneMe {
    mapping(address => uint256) public fundersToAmount;

    uint256 constant MINIMUM_VALUE = 10 * 10 ** 18;
    uint256 constant TARGET = 100 * 10 ** 18;
    address public owner;
    // 合约作为类型
    AggregatorV3Interface internal dataFeed;

    constructor() {
        // sepolia 测试网
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        owner = msg.sender;
    }

    function fund() external payable {
        require(convertEth2USD(msg.value) >= MINIMUM_VALUE, "Send more ETH"); // revert
        fundersToAmount[msg.sender] += msg.value;
    }

    function convertEth2USD(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10 ** 8);
    }

     /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function getFund() external {
        require(convertEth2USD(address(this).balance) >= TARGET, "Target is not reached");
        require(msg.sender == owner, "this function can only be called by owner");
        // transfer: transfer ETH revert if tx failed
        // payable(msg.sender).transfer(address(this).balance);
        // send    : transfer ETH and return false if failed
        // bool success = payable(msg.sender).send(address(this).balance);    
        // require(success, "error");
        // call    : transfer ETH with data return value of function and bool 
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "error");
    }

    function transferOwnership(address newOwner) public  {
        require(msg.sender == owner, "this function can only be called by owner");
        owner = newOwner;
    }

    function reFund() external {
        require(convertEth2USD(address(this).balance) < TARGET, "Target is reached");
        require(fundersToAmount[msg.sender] != 0, "this is no fund for you");
        (bool success, ) = payable(msg.sender).call{value: fundersToAmount[msg.sender]}("");
        require(success, "error");
        fundersToAmount[msg.sender] = 0;
    }
}
