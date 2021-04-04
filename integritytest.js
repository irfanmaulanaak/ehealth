const Web3 = require('web3');
const compiledFactory = require("./build/Ehealth.json");

const ethprovider = new Web3.providers.HttpProvider("http://34.70.214.154:8545");
const web3 = new Web3('http://');
web3.setProvider(ethprovider);


// console.log(web3);

const getDeployedByteCode = async () => {
    try {
        // Smart Contract Integrity
        const bchaincode = await web3.eth.getCode("0x1357A68b2C59F47727025Bb91d2C8D83e8cE2aDa");
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