// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

contract CreateProposal is Script {
  address internal constant PAYLOAD_ADDRESS = address(0);
  bytes32 internal constant IPFS_HASH = bytes32(0);

  function run() external {
    require(
      PAYLOAD_ADDRESS != address(0),
      "ERROR: PAYLOAD_ADDRESS can't be address(0)"
    );
    require(IPFS_HASH != bytes32(0), "ERROR: IPFS_HASH can't be bytes32(0)");

    address[] memory targets = new address[](1);
    targets[0] = PAYLOAD_ADDRESS;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute()';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = '';
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    vm.startBroadcast();
    AaveGovernanceV2.GOV.create(
      IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls,
      IPFS_HASH
    );
    vm.stopBroadcast();
  }
}
