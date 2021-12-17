// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Privacy {

  bool public locked = true;
  uint256 public ID = block.timestamp;
  bytes32 public a = 0x0000000000000000000000000000000000000000000000000000000000000001;
  bytes16 public b = bytes16(a);
  bytes8 public c = bytes8(b);
  uint256 public timestamp = now;
  uint16 public awkwardness = uint16(timestamp);
  bytes32[3] public data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }
  
  function getSolution() view public returns (bytes16) {
      return bytes16(data[2]);
  }
}