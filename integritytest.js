const Web3 = require('web3');
const compiledFactory = require("./build/Ehealth.json");

const ethprovider = new Web3.providers.HttpProvider("http://35.206.67.246:8545");
const web3 = new Web3('http://');
web3.setProvider(ethprovider);


// console.log(web3);

const getDeployedByteCode = async () => {
    try {
        // Smart Contract Integrity
        const bchaincode = await web3.eth.getCode("0xdBEFd0E76d4557E0184e581509cbc0B7ecE3A3f9");
        const herecode = "0x"+compiledFactory.evm.deployedBytecode.object

        if(bchaincode == herecode){
            console.log("Bytecode have same values.")
        }
        else{
            console.log("Bytecode have different values.")
        }
    } catch (error) {
        console.log(error)
    }
};
getDeployedByteCode();