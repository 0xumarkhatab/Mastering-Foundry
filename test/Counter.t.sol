// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {stdError} from "forge-std/StdError.sol";

import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
        console.log("test has been passed but yes let's change gta ");
    }

    function testFuzz_CanNotSetMoreThanUint256Max(uint256 x) public {
        vm.assume(x > 0);
        vm.expectRevert(stdError.arithmeticError);
        counter.setNumber(x + type(uint256).max);
        assertEq(counter.number(), x + type(uint256).max);
        console.log("test has been passed");
    }

    function test_ZeroAddressCanNotIncrement() public {
        vm.prank(address(0));
        vm.expectRevert(Counter.zeroAddressDetected.selector);
        counter.increment();
        vm.stopPrank();
    }
}
