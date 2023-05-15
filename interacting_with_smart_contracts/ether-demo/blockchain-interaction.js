import { ethers } from "ethers"
import dotenv from "dotenv"

dotenv.config()

const network = "homestead"

const provider = new ethers.providers.InfuraProvider(network, process.env.INFURA_API_KEY)

// the following points to the dai contract address
const address = "dai.tokens.ethers.eth"

// ABI: application binary interface -> allows us to interact with smart contracts
// allows to encode regular plain text data into binary format so that EVM understands
// functions being called in smart contract
const daiAbi = [
	// Some details about the token
	"function name() view returns (string)",
	"function symbol() view returns (string)",

	// get the account balance
	"function balanceOf(address) view returns (uint)",

	// send some of your tokens to someone else
	"function transfer(address to, uint amount)",

	// an event triggered whenever anyone transfers to someone else
	"event Transfer(address indexed from, address indexed to, uint amount)"
]

// local reference of actual contract in the blockchain
const daiContract = new ethers.Contract(address, daiAbi, provider)

// listening to events:
// daiContract.on("Transfer", (from, to, amount) => {
// 	console.log(from, to, amount)
// })

// can call Transfer because it is specified in the abi
const filter = daiContract.filters.Transfer()

// query the last 1000 blocks
const result = await daiContract.queryFilter(filter, -1000)

console.log(result)
