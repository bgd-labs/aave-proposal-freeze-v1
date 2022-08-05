// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import "forge-std/console.sol";

import {ProposalPayloadAaveFreezeV1} from '../src/contracts/ProposalPayloadAaveFreezeV1.sol';
import {ILendingPoolAddressesProvider} from '../src/interfaces/ILendingPoolAddressesProvider.sol';
import {ILendingPoolCore} from '../src/interfaces/ILendingPoolCore.sol';
import {GovHelpers, IAaveGov} from './helpers/AaveGovHelpers.sol';

contract ProposalPayloadAaveFreezeV1Test is Test {
  ILendingPoolAddressesProvider public constant AAVE_V1_ADDRESS_PROVIDER = 
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  function setUp() public {}

  function testProposal() public {

    ProposalPayloadAaveFreezeV1 payload = new ProposalPayloadAaveFreezeV1();

    address[] memory targets = new address[](1);
    targets[0] = address(payload);
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute()';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = '';
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    IAaveGov.SPropCreateParams memory createParams = IAaveGov
      .SPropCreateParams({
        executor: GovHelpers.SHORT_EXECUTOR,
        targets: targets,
        values: values,
        signatures: signatures,
        calldatas: calldatas,
        withDelegatecalls: withDelegatecalls,
        ipfsHash: bytes32(0)
      });

    uint256 proposalId = GovHelpers.createProposal(vm, createParams);

    GovHelpers.passVoteAndExecute(vm, proposalId);

    _validateFreeze();
  }

  function _validateFreeze() internal {
    ILendingPoolCore lendingPoolCore = 
      ILendingPoolCore(AAVE_V1_ADDRESS_PROVIDER.getLendingPoolCore());

    address[] memory reserves = lendingPoolCore.getReserves();

    for(uint256 i=0; i<reserves.length; i++) {
      assertTrue(lendingPoolCore.getReserveIsFreezed(reserves[i]));
    }
  }
}