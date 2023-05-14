import { ethers } from "ethers"

const API_KEY = process.env.API_KEY

const network = "homestead"

const provider = new ethers.providers.InfuraProvider(network, API_KEY)

const blockNumber = await provider.getBlockNumber()

console.log(blockNumber)
