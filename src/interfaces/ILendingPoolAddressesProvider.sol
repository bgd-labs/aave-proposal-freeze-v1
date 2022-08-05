// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILendingPoolAddressesProvider {
    function getLendingPoolCore() external view returns (address);
    function getLendingPoolConfigurator() external view returns (address);
}