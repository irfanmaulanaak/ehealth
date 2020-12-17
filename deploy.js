const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const ethprovider = new Web3.providers.HttpProvider("http://localhost:8545");
const web3 = new Web3('http://');
web3.setProvider(ethprovider);


console.log(web3);

const deploy = async () => {
    console.log("start")
    const accounts = await web3.eth.getAccounts();
    const account = "0x3653C607862E812c85a0541fbEAC407f3FFa26AD"

    console.log('Attempting to deploy from account ', accounts[0])

    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode})
        .send({ from: account });
    console.log(interface);
    console.log('Contract deployed to ',result.options.address)
};
deploy();
