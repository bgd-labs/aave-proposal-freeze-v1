// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILendingPool {
   function getReserves() external view returns (address[] memory);
}