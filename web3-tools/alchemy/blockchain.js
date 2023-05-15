import { ethers } from "ethers"
import dotenv from "dotenv"

dotenv.config()

const provider = new ethers.AlchemyProvider("homestead", process.env.ALCHEMY_API_KEY)

const blockNumber = await provider.getBlockNumber()
console.log(blockNumber)
