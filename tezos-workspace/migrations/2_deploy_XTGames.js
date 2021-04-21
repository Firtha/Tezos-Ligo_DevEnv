const XTGames = artifacts.require("XTGames");

module.exports = deployer => {
  deployer.deploy(XTGames, 0);
};