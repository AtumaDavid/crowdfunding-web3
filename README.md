- [Getting Started](#getting-started)
- [Building the project](#building-the-project)
- [Deploying Contracts](#deploying-contracts)
- [Releasing Contracts](#releasing-contracts)
- [Important Info](#important-info)

## Getting Started

Create a project using this example:

```bash
npx thirdweb create --contract --template hardhat-javascript-starter
npx thirdweb@latest create --contract
```

## Building the project

After any changes to the contract, run:

```bash
npm run build
# or
yarn build
```

to compile your contracts. This will also detect the [Contracts Extensions Docs](https://portal.thirdweb.com/contractkit) detected on your contract.

## Deploying Contracts

When you're ready to deploy your contracts, just run one of the following command to deploy you're contracts:

```bash
npm run deploy
# or
yarn deploy
```

## Releasing Contracts

If you want to release a version of your contracts publicly, you can use one of the followings command:

```bash
npm run release
# or
yarn release
```

## Important Info

- msg: msg is a global variable in Solidity that holds details about the transaction that called the contract. It includes:
  - msg.sender: The address of the sender (caller) of the transaction.
  - msg.value: The amount of Ether (in wei) sent with the transaction.
  - msg.data: The data payload (calldata) sent with the transaction.
  - msg.sig: The first four bytes of msg.data, which is the function identifier.
