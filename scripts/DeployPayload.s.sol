// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {ProposalPayloadAaveFreezeV1} from '../src/contracts/ProposalPayloadAaveFreezeV1.sol';

contract DeployL1Proposal is Script {
  function run() external {
    vm.startBroadcast();
    new ProposalPayloadAaveFreezeV1();
    vm.stopBroadcast();
  }
}
