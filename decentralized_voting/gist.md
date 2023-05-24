mkdir project
cd project
mkdir backend, cd backend
npx hardhat init
clear contract created and develop yours
then test, write testing functions, then: npx hardhat test
then deploy script, write it
then can go ahead and write frontend in root directory (npx create-react-app frontend)
in frontend, write contract/script that has abi and contract address
in backend, run node: npx hardhat node
split terminal, then run: npx hardhat run ./scripts/deploy.js --network localhost (generates address and abi)
json gets generated in backend, use this info in script
