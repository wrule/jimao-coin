const ConvertLib = artifacts.require("ConvertLib");
const JimaoCoin = artifacts.require("JimaoCoin");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, JimaoCoin);
  deployer.deploy(JimaoCoin);
};
