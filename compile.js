const path = require('path');
const fs = require('fs');
const solc = require('solc');

//menulis path seperti ini agar dapat memastikan kompatibilitas dalam lintas platform
const contractPath = path.resolve(__dirname, 'contracts', 'Ehealth.sol');
const source = fs.readFileSync(contractPath, 'utf8');
console.log(source)
module.exports = solc.compile(source,1).contracts[':Ehealth'];
