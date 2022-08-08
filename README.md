# Freeze all reserves on Aave v1 Ethereum
Repository containing the necessary smart contracts to propose freezing all reserves on the Aave v1 Ethereum market.

One of the tasks in the [Aave <> BGD engagement](https://governance.aave.com/t/aave-bored-ghosts-developing-bgd/7527) is the final closure of the Aave V1 Ethereum, which is a deprecated pool after V2 and the upcoming V3 version.
Closure in this context means activating the necessary mechanisms to stop the possibility of providing liquidity and borrowing assets. Only keeping withdrawals, repayments, and liquidations active.

Accepting this proposal assumes that the proper communication has been done with the projects built on top of Aave V1, so it won't cause any trouble.

## Implementations

### Governance Payloads

[ProposalPayloadAaveFreezeV1](/src/contracts/ProposalPayloadAaveFreezeV1.sol)
- For each reserve in the `LendingPoolCore` contract calls `freezeReserve` function on the `LendingPoolConfigurator` contract


### Tests
[ProposalPayloadAaveFreezeV1Test](./src/test/ProposalPayloadAaveFreezeV1Test.sol)
- Validates that after proposal is accepted, all reserves are frozen in the `LendingPoolCore` contract


## Setup
### Install

To install and execute the project locally, you need:

- ```npm install``` : As there are some scripts to make deployment easier.
- ```forge install``` : This project is made using [Foundry](https://book.getfoundry.sh/) so to run it you will need to install it, and then install its dependencies.


### Tests

We have used foundry to create this solidity project, so to run the tests you will need to run ```forge test```. But as we are using already deployed contracts, the tests need to be run in a fork environment. For this you will need to execute this command:

```
➜ forge test --fork-url https://rpc.flashbots.net -vvvv --fork-block-number <latest block number>
```
Alternatively you can also run ```make test``` 

### Copyright

2022 BGD Labs
