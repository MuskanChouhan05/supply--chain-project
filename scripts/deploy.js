const hre = require("hardhat");

async function main() {
  console.log("Deploying SupplyChainVerification contract...");

  // Get the ContractFactory
  const SupplyChainVerification = await hre.ethers.getContractFactory("SupplyChainVerification");
  
  // Deploy the contract
  const supplyChain = await SupplyChainVerification.deploy();

  // Wait for deployment to finish
  await supplyChain.waitForDeployment();

  const address = await supplyChain.getAddress();
  console.log(`SupplyChainVerification deployed to: ${address}`);
}

// Execute deployment
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
