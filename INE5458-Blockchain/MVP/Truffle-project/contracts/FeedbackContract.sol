// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FeedbackContract {
    struct Feedback {
        address client;
        bytes32 messageHash;
    }
    mapping(uint => Feedback) private feedbacks;
    uint feedbackCount = 0;

    function saveHash(bytes32 _hash) external {
        feedbacks[feedbackCount] = Feedback({ client: msg.sender, messageHash: _hash });
        feedbackCount++;
    }
}