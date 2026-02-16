# Web3 Challenges

Solidity smart contract challenge solutions built with Solidity ^0.8.20.

## Challenges

### 1. Check Even Number
**File:** `EvenOddContract.sol`

**Problem:** Given an unsigned integer, determine whether it is even or odd.

**Solution:** Solidity doesn't have a built-in `isEven()` function, so we use the modulo operator (`%`). When a number is divided by 2 and the remainder is 0, the number is even. The expression `number % 2 == 0` returns `true` for even numbers and `false` for odd numbers. The function is marked `pure` since it doesn't read or modify any blockchain state.

```solidity
isEven(uint256 number) returns (bool)
```

---

### 2. Find Greatest Number
**File:** `MaxNumberContract.sol`

**Problem:** Given an array of unsigned integers, find and return the largest number.

**Solution:** Solidity doesn't provide a built-in `max()` function for arrays, so we implement a linear search. We initialize `max` with the first element, then iterate through the remaining elements. If any element is greater than the current `max`, we update it. After the loop completes, `max` holds the largest value. We also add a `require` check to ensure the array is not empty, preventing an out-of-bounds access on `numbers[0]`.

```solidity
findMaxNumber(uint256[] numbers) returns (uint256)
```

---

### 3. Storage Smart Contract
**File:** `StorageContract.sol`

**Problem:** Create a smart contract that can store a value and retrieve it later — the most fundamental read/write operation on the blockchain.

**Solution:** We declare a `uint256 private storedValue` state variable. State variables in Solidity are permanently stored on the blockchain. The `storeValue()` function writes a new value to this variable (a write/transaction operation that costs gas). The `readValue()` function is marked `view` because it only reads from the blockchain without modifying state, meaning it costs no gas when called externally. This pattern is the foundation of all blockchain data storage.

```solidity
storeValue(uint256 _newValue)
readValue() returns (uint256)
```

---

### 4. Compare Strings
**File:** `StringComparisonContract.sol`

**Problem:** Given two strings, determine whether they are identical or not.

**Solution:** Solidity does not support direct string comparison with `==` because strings are dynamically-sized reference types stored as byte arrays. Instead, we hash both strings using `keccak256(abi.encodePacked(str))` and compare their hashes. `abi.encodePacked()` converts the string into raw bytes, and `keccak256()` produces a fixed-size 32-byte hash. If two strings are identical, their hashes will be identical. This is the standard and most gas-efficient way to compare strings in Solidity.

```solidity
compareStrings(string memory str1, string memory str2) returns (bool)
```

---

### 5. Calculate Factorial
**File:** `FactorialContract.sol`

**Problem:** Given a non-negative integer `n`, calculate its factorial (`n!`). Factorial is the product of all positive integers up to `n`. For example: `5! = 5 × 4 × 3 × 2 × 1 = 120`.

**Solution:** We use an iterative approach with a `for` loop. We initialize `result` to 1 (since `0! = 1` and `1! = 1`), then multiply it by every integer from 2 up to `n`. This is preferred over recursion in Solidity because recursive calls consume more gas due to additional function call overhead and stack usage. When `n` is 0 or 1, the loop doesn't execute and `result` stays 1, which is mathematically correct.

```solidity
calculateFactorial(uint256 n) returns (uint256)
```
