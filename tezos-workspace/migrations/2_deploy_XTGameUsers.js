const XTGameUsers = artifacts.require("XTGameUsers");

module.exports = deployer => {
  deployer.deploy(XTGameUsers, 0);
};