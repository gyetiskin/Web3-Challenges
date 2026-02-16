pragma solidity ^0.8.4;

contract Gas {
    uint public c = 1;

    function calculateGas() external returns(uint _gasUsed) {
        uint gasStart = gasleft();
        ++c;
        uint gasEnd = gasleft();
        _gasUsed = gasStart - gasEnd - 3;
    }
}
