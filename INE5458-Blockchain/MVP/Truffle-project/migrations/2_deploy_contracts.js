// 2_deploy_contracts.js
const FeedbackContract = artifacts.require("FeedbackContract");

module.exports = function (deployer) {
    deployer.deploy(FeedbackContract);
};
