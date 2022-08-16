import ethers from "ethers";
import contract from "../out/ProposalPayloadAaveFreezeV1.sol/ProposalPayloadAaveFreezeV1.json" assert { type: "json" };
import GOV_ARTIFACT from "../out/AaveGovHelpers.sol/IAaveGov.json" assert { type: "json" };

const GOV = "0xEC568fffba86c094cf06b22134B23074DFE2252c";
const SHORT_EXECUTOR = "0xEE56e2B3D491590B5b31738cC34d5232F378a8D5";
const AAVE_WHALE = "0x25F2226B597E8F9514B3F68F00f494cF4f286491";

const provider = new ethers.providers.JsonRpcProvider(
  "https://rpc.tenderly.co/fork/5366cccf-8554-4891-a2ee-29b748054929"
);

const factory = new ethers.ContractFactory(
  contract.abi,
  contract.bytecode,
  provider.getSigner(AAVE_WHALE)
);

const payload = await factory.deploy();

const governance = new ethers.Contract(
  GOV,
  GOV_ARTIFACT.abi,
  provider.getSigner(AAVE_WHALE)
);

await (
  await governance.create(
    SHORT_EXECUTOR,
    [payload.address],
    [0],
    ["execute()"],
    ["0x0000000000000000000000000000000000000000000000000000000000000000"],
    [true],
    "0x0000000000000000000000000000000000000000000000000000000000000000"
  )
).wait();

const id = (await governance.getProposalsCount()) - 1;

console.log(id);
await provider.send("tenderly_setStorageAt", [
  GOV,
  ethers.BigNumber.from(
    ethers.utils.keccak256(
      ethers.utils.defaultAbiCoder.encode(["uint256", "uint256"], [id, 4])
    )
  ).add(11),
  ethers.utils.hexZeroPad(ethers.utils.parseEther(10).toHexString(), 32),
]);
