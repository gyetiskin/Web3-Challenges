pragma solidity ^0.8.4;

contract Gas {
    uint public c = 1;

    function calculateGas() external returns(uint _gasUsed) {
        _gasUsed = gasleft();
        ++c;
        _gasUsed -= gasleft();
    }
}
