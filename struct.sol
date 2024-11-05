// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    string strVar = "hello world";
    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }

    Info[] infos;
    function setHelloWorld(string memory newString, uint256 _id) public {
        Info memory info = Info(newString, _id, msg.sender);
        infos.push(info);
    }

    function sayHelloWorld(uint256 _id) public view returns (string memory) {
        for (uint256 i = 0; i < infos.length; i++) 
        {
            if (infos[i].id == _id) {
                return infos[i].phrase;
            }
        }
        return strVar;
    }
}
