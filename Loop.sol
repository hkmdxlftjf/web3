// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint u = 0; u < 10; u ++) {
            if (u == 3) {
                continue ;
            }
            if (u == 5) {
                break ;
            }
        }
        uint i = 0;
        while (i < 10) {
            i ++;
        }
    }

    
}