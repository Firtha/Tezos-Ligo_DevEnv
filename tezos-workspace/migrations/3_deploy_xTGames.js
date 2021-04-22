const xTGames = artifacts.require("XTGames");

module.exports = deployer => {
  deployer.deploy(xTGames, 0);
};