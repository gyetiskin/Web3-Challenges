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

---

### 2. Find Greatest Number
**File:** `MaxNumberContract.sol`

Finds the greatest number from a given array of integers.

```solidity
findMaxNumber(uint256[] numbers) returns (uint256)
```

- Input: Array of unsigned integers
- Output: The largest number in the array
- Logic: Iterates through the array comparing each element to find the maximum

---

### 3. Storage Smart Contract
**File:** `StorageContract.sol`

Store and retrieve a value on the blockchain.

```solidity
storeValue(uint256 _newValue)
readValue() returns (uint256)
```

- Input: Unsigned integer to store
- Output: The stored value
- Logic: Uses a state variable to persist data on the blockchain (basic read/write operations)
