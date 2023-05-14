import { ethers } from "ethers"
import dotenv from "dotenv"

dotenv.config()

const network = "homestead"

const provider = new ethers.providers.InfuraProvider(network, process.env.INFURA_API_KEY)

// const blockNumber = await provider.getBlockNumber()
// console.log(blockNumber)

// some rich dude's eth address lol
// const randomAddress = "0xaad385cbd69f195916b806fae1c24e70999b10e7"
// const balance = await provider.getBalance(randomAddress)
// console.log(parseInt(balance))
// const ethBalance = ethers.utils.formatEther(balance)
// console.log(ethBalance)

// const txCount = await provider.getTransactionCount(randomAddress)
// console.log(txCount)

// const blockNumber = await provider.getBlockNumber()
// // const block = await provider.getBlock(blockNumber) // info about a block
// const block = await provider.getBlockWithTransactions(blockNumber) // info about a block with transaction data
// console.log(block)

// get fee data
// const fee = await provider.getFeeData()
// const gasPrice = await provider.getGasPrice()
// console.log(gasPrice)

// print logs with applied filters
const addr = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
const filter = {
	address: addr,
	topics: [ethers.utils.id("Transfer(address,address,uint256)")]
}

// const logs = await provider.getLogs(filter)
// console.log(logs)

// listening for events
// provider.on(filter, (log) => {
// 	console.log(log)
// })

// listen once
// provider.once(filter, (log) => {
// 	console.log(log)
// })

// provider.off(filter) // stops after event happens
// const count = provider.listenerCount(filter)
// console.log(count)

// can check for blocks mined, pending blocks, errors, etc..
provider.on("block", (log) => {
	console.log(log)
})
