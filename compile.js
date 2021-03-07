const path = require("path");
const solc = require("solc");
const fs = require("fs-extra");
const buildPath = path.resolve(__dirname, "build");
const evotingPath = path.resolve(__dirname, "contracts", "Ehealth.sol");
const source = fs.readFileSync(evotingPath, "utf8");
var input = {
    language: "Solidity",
    sources: {
        "Ehealth.sol": {
            content: source
        }
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"]
            }
        }
    }
};
const output = JSON.parse(solc.compile(JSON.stringify(input)));
if (output.errors) {
    output.errors.forEach(err => {
        console.log(err.formattedMessage);
    });
} else {
    const contracts = output.contracts["Ehealth.sol"];
    fs.ensureDirSync(buildPath);
    for (let contractName in contracts) {
        const contract = contracts[contractName];
        fs.writeFileSync(
            path.resolve(buildPath, `${contractName}.json`),
            JSON.stringify(contract, null, 2),
            "utf8"
        );
        console.log("Check the json file at ", buildPath,`${contractName}.json`)
    }
}