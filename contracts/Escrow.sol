// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract Escrow {
    event Approved(uint256 _balance);
    address public depositor;
    address public beneficiary;
    address public arbiter;
    bool public isApproved;

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(
            msg.sender == arbiter,
            "Only the arbiter can approve this transaction"
        );
        uint256 balance = address(this).balance;
        (bool sent, ) = beneficiary.call{value: balance}("");
        require(sent, "Failed to send Ether");
        isApproved = true;
        emit Approved(balance);
    }
}
