// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILendingPoolCore {
   function getReserves() external view returns (address[] memory);
   function getReserveIsFreezed(address _reserve) external view returns (bool);
}