const Voting = artifacts.require("Counter");

module.exports = deployer => {
  deployer.deploy(Counter, 0);
};