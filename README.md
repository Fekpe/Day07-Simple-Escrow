# SimpleEscrow

A minimal, gas-optimized escrow smart contract for secure on-chain payments between a buyer and seller.

## 🔑 Key Concepts
- Escrow payment model
- Enum-based contract states
- Payable deposit and withdrawal
- Custom error handling
- Secure transfer via call()

## ✨ Features
✔ Only buyer can deposit  
✔ Only seller can withdraw  
✔ Single-use trusted transaction  
✔ Prevents re-entrancy by state locking  
✔ Custom errors for gas efficiency  

## 🔒 States
| State | Meaning |
|--------|---------|
| NotInitiated | No deposit yet |
| Deposited | Funds locked in escrow |
| Released | Funds withdrawn |

## 🚀 Functions
| Function | Role | Description |
|-----------|------|-------------|
| deposit() | Buyer | Deposit ETH into contract |
| withdraw() | Seller | Withdraw full amount |
| getContractBalance() | View | Check contract balance |


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
