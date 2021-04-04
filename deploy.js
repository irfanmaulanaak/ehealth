// const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const compiledEhealth = require('./build/Ehealth.json');

const ethprovider = new Web3.providers.HttpProvider("http://34.70.214.154:8545");
const web3 = new Web3('http://');
web3.setProvider(ethprovider);
const deploy = async () => {
    console.log("start")
    const account = '0x743783c84fd1287BEE94142CDD7EB5Ed41079cD0'
    console.log('Attempting to deploy from account ', account)

    const result = await new web3.eth.Contract(compiledEhealth.abi)
        .deploy({ data: "0x"+compiledEhealth.evm.bytecode.object})
        .send({ from: account, gasPrice: 150000000 });
    
    console.log(compiledEhealth.abi)
    console.log('Contract deployed to ',result.options.address)
    
};
deploy();