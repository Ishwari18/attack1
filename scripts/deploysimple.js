const hre = require("hardhat");

async function main() {
  console.log("deploying...");

  const SimpleFlashLoan = await hre.ethers.getContractFactory(
    "SimpleFlashLoan"
  );
  const simpleFlashLoan = await SimpleFlashLoan.deploy(
    "0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e"
  );

  await simpleFlashLoan.deployed();

  console.log(` deployed to ${simpleFlashLoan.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
