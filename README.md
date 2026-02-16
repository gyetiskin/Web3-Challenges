# Web3 Challenges

Solidity smart contract challenge solutions built with Solidity ^0.8.20.

## Challenges

### 1. Check Even Number
**File:** `EvenOddContract.sol`

Checks whether a given number is even or odd.

```solidity
isEven(uint256 number) returns (bool)
```

- Input: Unsigned integer
- Output: `true` if even, `false` if odd
- Logic: Uses the modulo operator (`% 2 == 0`) to determine if the number is even
