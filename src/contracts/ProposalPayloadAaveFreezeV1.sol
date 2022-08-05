// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../interfaces/ILendingPool.sol';
import '../interfaces/ILendingPoolConfigurator.sol';
import '../interfaces/ILendingPoolAddressesProvider.sol';

/**
 * @title ProposalPayloadAaveFreezeV1
 * @author BGD Labs
 * @notice Aave governance payload to freeze all the reserves on Aave v1 Ethereum
 */
contract ProposalPayloadAaveFreezeV1 {
  ILendingPoolAddressesProvider public constant ADDRESS_PROVIDER = 
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  function execute() external {
    ILendingPool lendingPool = 
      ILendingPool(ADDRESS_PROVIDER.getLendingPool());
    ILendingPoolConfigurator lendingPoolConfigurator =
      ILendingPoolConfigurator(ADDRESS_PROVIDER.getLendingPoolConfigurator());

    address[] memory reserves = lendingPool.getReserves();

    for(uint256 i=0; i<reserves.length; i++) {
        lendingPoolConfigurator.freezeReserve(reserves[i]);
    }
  }
}