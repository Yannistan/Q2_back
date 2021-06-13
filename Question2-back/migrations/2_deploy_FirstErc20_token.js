const FirstErc20 = artifacts.require("FirstErc20");
const { BN } = require("@openzeppelin/test-helpers");

module.exports = async (deployer) => {
  await deployer.deploy(
    FirstErc20,
    "FirstErc20",
    "CALK",
    18,
    new BN("1000000000000000000000000"),
    new BN("1000000000000000000000000"),
    "0x44F31c324702C418d3486174d2A200Df1b345376"
  );
};
