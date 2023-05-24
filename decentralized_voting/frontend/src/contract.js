import { ethers } from "ethers"

const address = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"
const abi = [
	"event MemberJoined(address indexed member, uint256 joinedAt)",
	"event VoteCreated(address indexed owner, uint256 indexed voteId, uint256 indexed createdAt, uint256 endTime)",
	"event Voted(address indexed voter, uint256 indexed voteId, uint256 indexed option, uint256 createdAt)",
	"function createVote(string uri, uint256 endTime, uint256 options)",
	"function didVote(address member, uint256 voteId) view returns (bool)",
	"function getVote(uint256 voteId) view returns (string, address, uint256[], uint256)",
	"function join()",
	"function members(address) view returns (bool)",
	"function vote(uint256 voteId, uint256 option)"
]

// const provider = new ethers.BrowserProvider(window.ethereum)

let signer = null

let provider
if (window.ethereum == null) {
	// If MetaMask is not installed, we use the default provider,
	// which is backed by a variety of third-party services (such
	// as INFURA). They do not have private keys installed so are
	// only have read-only access
	console.log("MetaMask not installed; using read-only defaults")
	provider = ethers.getDefaultProvider()
} else {
	// Connect to the MetaMask EIP-1193 object. This is a standard
	// protocol that allows Ethers access to make all read-only
	// requests through MetaMask.
	provider = new ethers.BrowserProvider(window.ethereum)

	// It also provides an opportunity to request access to write
	// operations, which will be performed by the private key
	// that MetaMask manages for the user.
	signer = await provider.getSigner()
}

export const connect = async () => {
	await provider.send("eth_requestAccounts", [])
	return getContract()
}

export const getContract = async () => {
	// const signer = provider.getSigner()
	const contract = new ethers.Contract(address, abi, signer)
	return { signer: signer, contract: contract }
}
