pragma solidity ^0.8.4;

contract Solution {
    struct Item {
        string name;
        uint256 price;
    }

    Item[] public inventory;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addItemToInventory(
        string memory _name,
        uint256 _price
    ) public onlyOwner {
        inventory.push(Item(_name, _price));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function getInventory() public view returns (Item[] memory) {
        return inventory;
    }

    function clearInventory() private onlyOwner {
        delete inventory;
    }
}
