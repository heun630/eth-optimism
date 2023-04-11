import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const initialSupply = ethers.utils.parseEther("1000");
  const l1Token = "0x1234567890123456789012345678901234567890";
  const l1Bridge = "0x0987654321098765432109876543210987654321";
  const l2CrossDomainMessenger = "0x1111111111111111111111111111111111111111";

  const L2ERC20 = await ethers.getContractFactory("L2ERC20");
  const l2erc20 = await L2ERC20.deploy(
      initialSupply,
      "L2 Test Token",
      "L2TT",
      l1Token,
      l1Bridge,
      l2CrossDomainMessenger
  );

  await l2erc20.deployed();
  console.log("L2ERC20 deployed to:", l2erc20.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
