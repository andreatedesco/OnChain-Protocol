const hre = require("hardhat");
async function main() {
  
  // ================================================================================================ //

  const deployLibraries = false; 
  const deploy721ContractExample = true; 
  const deploy1155ContractExample = true;

  // ================================================================================================ //

  const signers = await ethers.getSigners();
  var signer = signers[0]; 
  var builderAddress = "0xf97F5874C493cCCB288eCDac0d684A0cA164F773";
  var storageAddress = "0xbF7D8FbdE3ba6cfb5C88D0347781e297197F6027";

  // ================================================================================================ //

  if(deployLibraries){
    Factory = await hre.ethers.getContractFactory("OnChainMetadataBuilder");
    CanvasDeployerContract = await Factory.connect(signer).deploy();
    builderAddress = (await CanvasDeployerContract.deployed()).address;
    console.log("OnChainMetadataBuilder deployed to:", builderAddress);

    Factory = await hre.ethers.getContractFactory("OnChainMetadataStorage", { libraries: { OnChainMetadataBuilder: builderAddress }});
    CanvasDeployerContract = await Factory.connect(signer).deploy();
    storageAddress = (await CanvasDeployerContract.deployed()).address;
    console.log("OnChainMetadataStorage deployed to:", storageAddress);
  }

  if(deploy721ContractExample){
    Factory = await hre.ethers.getContractFactory("ERC721OnChainMetadataExample", { libraries: {
      OnChainMetadataStorage: storageAddress,
    }});
    CanvasDeployerContract = await Factory.connect(signer).deploy();
    CanvasDeployerAddress = (await CanvasDeployerContract.deployed()).address;
    console.log("ERC721OnChainMetadataExample deployed to:", CanvasDeployerAddress);
  }
  
  if(deploy1155ContractExample){
    Factory = await hre.ethers.getContractFactory("ERC1155OnChainMetadataExample", { libraries: {
      OnChainMetadataStorage: storageAddress,
    }});
    CanvasDeployerContract = await Factory.connect(signer).deploy();
    CanvasDeployerAddress = (await CanvasDeployerContract.deployed()).address;
    console.log("ERC1155OnChainMetadataExample deployed to:", CanvasDeployerAddress);
  }
}

function wait(ms){
    var start = new Date().getTime();
    var end = start;
    while(end < start + ms) {
      end = new Date().getTime();
   }
  }

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
