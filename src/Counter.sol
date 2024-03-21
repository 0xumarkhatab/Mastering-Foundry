// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    error zeroAddressDetected();

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        if (msg.sender == address(0)) {
            revert zeroAddressDetected();
        }
        number++;
    }
}
