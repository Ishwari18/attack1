const hre = require("hardhat");

const { ethers } = require("ethers");
const provider = new ethers.providers.getDefaultProvider(
  "http://127.0.0.1:8545/"
);

const contractAddress = "0x47c05BCCA7d57c87083EB4e586007530eE4539e9";
const contractABI = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_addressProvider",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "asset",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "val",
        type: "uint256",
      },
    ],
    name: "Log",
    type: "event",
  },
  {
    inputs: [],
    name: "ADDRESSES_PROVIDER",
    outputs: [
      {
        internalType: "contract IPoolAddressesProvider",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "POOL",
    outputs: [
      {
        internalType: "contract IPool",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "asset",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "premium",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "initiator",
        type: "address",
      },
      {
        internalType: "bytes",
        name: "params",
        type: "bytes",
      },
    ],
    name: "executeOperation",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_token",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
    ],
    name: "requestFlashLoan",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];
const privatekey1 =
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";

const contractInteraction = async () => {
  const Contract = new ethers.Contract(contractAddress, contractABI, provider);
  const wallet = new ethers.Wallet(privatekey1, provider);

  //instance of the contract that is cnnected with the wallet
  const contractwallet = Contract.connect(wallet);

  contractwallet.requestFlashLoan(
    "0x73bFE136fEba2c73F441605752b2B8CAAB6843Ec",
    100000
  );

  let listen = async () => {
    Contract.on("Log", (asset, val, event) => {
      let data = {
        asset,
        val,
        event,
      };
      console.log(data)
    });
  };

  listen();
};

contractInteraction();
