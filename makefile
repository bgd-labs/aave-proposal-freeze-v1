# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes --via-ir
test   :; forge test --fork-url https://rpc.flashbots.net -vvvv --fork-block-number 15276550
