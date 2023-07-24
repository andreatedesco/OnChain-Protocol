require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

const { API_URL_MUMBAI, PRIVATE_KEY, POLYGONSCAN_API_KEY } = process.env;

module.exports = {
  solidity: {
    version: "0.8.14",
    settings: {
      viaIR: true,
      optimizer: {
        enabled: true,
        runs: 0,
      },
    },
  },
  paths: {
    artifacts: "./src/artifacts",
  },
  networks: {
    hardhat: {
      chainId: 80001,
    },
    mumbai: {
      url: API_URL_MUMBAI,
      accounts: 
      [
        PRIVATE_KEY,
      ],
    },
  },
  etherscan: {
    apiKey: {
        polygonMumbai: POLYGONSCAN_API_KEY,
    }
  }
};