const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'hedgehog awake fitness make mother panic pulp amused prevent jaguar play act',
    'https://rinkeby.infura.io/v3/605991ac17794cb2b31cc6d6ec7562fa'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account ', accounts[0])

    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode})
        .send({ from: accounts[0] });
    console.log(interface);
    console.log('Contract deployed to ',result.options.address)
};
deploy();
