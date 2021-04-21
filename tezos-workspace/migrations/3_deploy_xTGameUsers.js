const xTGameUsers = artifacts.require("XTGameUsers");

module.exports = deployer => {
  deployer.deploy(xTGameUsers, 0);
};