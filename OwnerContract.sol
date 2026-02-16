// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OwnerContract {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
