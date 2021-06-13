 // FirstErc20 is an artifact of the FirstErc20 contract
const FirstErc20 = artifacts.require('FirstErc20');
// CALKIco is an artifact of the CALKIco contract
const CALKIco = artifacts.require('CALKIco');
const { BN } = require('@openzeppelin/test-helpers');

module.exports = async (deployer) => {
  await deployer.deploy(
    CALKIco,
    new BN('100000000000000000'),
    '0x44F31c324702C418d3486174d2A200Df1b345376',
    FirstErc20.address, // use FirstErc20 address from artifact
  );
};


