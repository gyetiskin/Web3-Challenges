# Web3 Challenges

Solidity smart contract challenge solutions built with Solidity ^0.8.20.

## Challenges

### 1. Check Even Number
**File:** `EvenOddContract.sol`

**Problem:** Given an unsigned integer, determine whether it is even or odd.

**Solution:** Solidity doesn't have a built-in `isEven()` function, so we use the modulo operator (`%`). When a number is divided by 2 and the remainder is 0, the number is even. The expression `number % 2 == 0` returns `true` for even numbers and `false` for odd numbers. The function is marked `pure` since it doesn't read or modify any blockchain state.

**Before:**
```solidity
function isEven(uint256 number) external pure returns (bool) {
    // empty
}
```

**After:**
```solidity
function isEven(uint256 number) external pure returns (bool) {
    return number % 2 == 0;
}
```

---

### 2. Find Greatest Number
**File:** `MaxNumberContract.sol`

**Problem:** Given an array of unsigned integers, find and return the largest number.

**Solution:** Solidity doesn't provide a built-in `max()` function for arrays, so we implement a linear search. We initialize `max` with the first element, then iterate through the remaining elements. If any element is greater than the current `max`, we update it. After the loop completes, `max` holds the largest value. We also add a `require` check to ensure the array is not empty, preventing an out-of-bounds access on `numbers[0]`.

**Before:**
```solidity
function findMaxNumber(uint256[] memory numbers) external pure returns (uint256) {
    // empty
}
```

**After:**
```solidity
function findMaxNumber(uint256[] memory numbers) external pure returns (uint256) {
    require(numbers.length > 0, "Array must not be empty");

    uint256 max = numbers[0];

    for (uint256 i = 1; i < numbers.length; i++) {
        if (numbers[i] > max) {
            max = numbers[i];
        }
    }

    return max;
}
```

---

### 3. Storage Smart Contract
**File:** `StorageContract.sol`

**Problem:** Create a smart contract that can store a value and retrieve it later — the most fundamental read/write operation on the blockchain.

**Solution:** We declare a `uint256 private storedValue` state variable. State variables in Solidity are permanently stored on the blockchain. The `storeValue()` function writes a new value to this variable (a write/transaction operation that costs gas). The `readValue()` function is marked `view` because it only reads from the blockchain without modifying state, meaning it costs no gas when called externally. This pattern is the foundation of all blockchain data storage.

**Before:**
```solidity
contract StorageContract {

    function storeValue(uint256 _newValue) public {
        // empty
    }

    function readValue() public view returns (uint256) {
        // empty
    }
}
```

**After:**
```solidity
contract StorageContract {
    uint256 private storedValue;

    function storeValue(uint256 _newValue) public {
        storedValue = _newValue;
    }

    function readValue() public view returns (uint256) {
        return storedValue;
    }
}
```

---

### 4. Compare Strings
**File:** `StringComparisonContract.sol`

**Problem:** Given two strings, determine whether they are identical or not.

**Solution:** Solidity does not support direct string comparison with `==` because strings are dynamically-sized reference types stored as byte arrays. Instead, we hash both strings using `keccak256(abi.encodePacked(str))` and compare their hashes. `abi.encodePacked()` converts the string into raw bytes, and `keccak256()` produces a fixed-size 32-byte hash. If two strings are identical, their hashes will be identical. This is the standard and most gas-efficient way to compare strings in Solidity.

**Before:**
```solidity
function compareStrings(string memory str1, string memory str2) external pure returns (bool) {
    // empty
}
```

**After:**
```solidity
function compareStrings(string memory str1, string memory str2) external pure returns (bool) {
    return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
}
```

---

### 5. Calculate Factorial
**File:** `FactorialContract.sol`

**Problem:** Given a non-negative integer `n`, calculate its factorial (`n!`). Factorial is the product of all positive integers up to `n`. For example: `5! = 5 × 4 × 3 × 2 × 1 = 120`.

**Solution:** We use an iterative approach with a `for` loop. We initialize `result` to 1 (since `0! = 1` and `1! = 1`), then multiply it by every integer from 2 up to `n`. This is preferred over recursion in Solidity because recursive calls consume more gas due to additional function call overhead and stack usage. When `n` is 0 or 1, the loop doesn't execute and `result` stays 1, which is mathematically correct.

**Before:**
```solidity
function calculateFactorial(uint256 n) public pure returns (uint256) {
    // empty
}
```

**After:**
```solidity
function calculateFactorial(uint256 n) public pure returns (uint256) {
    uint256 result = 1;

    for (uint256 i = 2; i <= n; i++) {
        result *= i;
    }

    return result;
}
```

---

### 6. Owner Smart Contract
**File:** `OwnerContract.sol`

**Problem:** Save the deployer's account address and make it the owner of the contract, then provide a way to retrieve that address.

**Solution:** We use `msg.sender` inside the `constructor()` to capture the address of the account that deploys the contract. The constructor runs only once — at deployment time — so `msg.sender` at that moment is always the deployer. We store it in a `private` state variable `owner`. The `getOwner()` function is marked `view` because it only reads from state without modifying it. This is the foundational ownership pattern used in most real-world smart contracts (e.g. OpenZeppelin's `Ownable`).

**Before:**
```solidity
contract OwnerContract {

    function getOwner() external view returns (address) {
        // empty
    }
}
```

**After:**
```solidity
contract OwnerContract {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
```
