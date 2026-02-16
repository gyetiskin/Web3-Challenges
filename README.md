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

**Problem:** Create a smart contract that can store a value and retrieve it later , the most fundamental read/write operation on the blockchain.

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

**Solution:** We use `msg.sender` inside the `constructor()` to capture the address of the account that deploys the contract. The constructor runs only once, at deployment time, so `msg.sender` at that moment is always the deployer. We store it in a `private` state variable `owner`. The `getOwner()` function is marked `view` because it only reads from state without modifying it. This is the foundational ownership pattern used in most real-world smart contracts (e.g. OpenZeppelin's `Ownable`).

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

---

### 7. Cryptocurrency Round Trip
**File:** `CryptoTrader.sol`

**Problem:** You have accounts on multiple exchanges. Each exchange has a wallet balance and a network fee to transfer funds to the next exchange. Starting from an exchange, you transfer funds clockwise. Determine the starting exchange index from which you can complete a full round trip consolidating all funds. If not possible, return `-1`.

**Solution:** This is the classic "Gas Station" problem. We track two values: `totalBalance` (sum of all `walletBalances[i] - networkFees[i]`) and `currentBalance` (running balance from the current candidate start). If `totalBalance < 0`, there's not enough funds overall, return `-1`. As we iterate, whenever `currentBalance` drops below 0, it means we can't start from any previous index, so we reset and try starting from the next exchange. This greedy approach works in O(n) time with a single pass — no need for brute-force nested loops.

**Example:** `walletBalances = [1,2,3,4,5]`, `networkFees = [3,4,5,1,2]`
| Exchange | net (balance - fee) | currentBalance | startIndex |
|----------|-------------------|----------------|------------|
| 0 | 1 - 3 = -2 | -2 , reset to 0 | 1 |
| 1 | 2 - 4 = -2 | -2 , reset to 0 | 2 |
| 2 | 3 - 5 = -2 | -2 , reset to 0 | 3 |
| 3 | 4 - 1 = 3 | 3 | 3 |
| 4 | 5 - 2 = 3 | 6 | 3 |

Total = 0 (>= 0), so answer is **3**.

**Before:**
```solidity
function roundTrip(
            int[] memory walletBalances,
            int[] memory networkFees
            ) public returns (int) {
    // empty
}
```

**After:**
```solidity
function roundTrip(
            int[] memory walletBalances,
            int[] memory networkFees
            ) public pure returns (int) {
    int totalBalance = 0;
    int currentBalance = 0;
    int startIndex = 0;

    for (uint256 i = 0; i < walletBalances.length; i++) {
        int net = walletBalances[i] - networkFees[i];
        totalBalance += net;
        currentBalance += net;

        if (currentBalance < 0) {
            currentBalance = 0;
            startIndex = int(i + 1);
        }
    }

    if (totalBalance < 0) {
        return -1;
    }

    return startIndex;
}
```

---

### 8. Hello World
**File:** `HelloWorld.sol`

**Problem:** Return the string "Hello World" from a smart contract function.

**Solution:** Simply return a string literal. In Solidity, strings must be returned with the `memory` keyword because they are dynamically-sized and need to be stored in temporary memory during execution. This is the most basic Solidity challenge, a starting point for smart contract development.

**Before:**
```solidity
function helloWorld() public pure returns (string memory) {
    //Code here!
}
```

**After:**
```solidity
function helloWorld() public pure returns (string memory) {
    return "Hello World";
}
```

---

### 9. Sum of Two Integers
**File:** `SumOfTwoIntegers.sol`

**Problem:** Calculate the sum of two unsigned integers `a` and `b`.

**Solution:** Return `a + b`. In Solidity ^0.8.0+, arithmetic overflow is checked by default, so if the sum exceeds `uint256` max value, the transaction will revert automatically. For the given constraints (0 <= a,b <= 10^5), overflow is not a concern.

**Before:**
```solidity
function sumOfTwoIntegers(uint256 a, uint256 b)
    public
    pure
    returns (uint256)
{
    //TODO
}
```

**After:**
```solidity
function sumOfTwoIntegers(uint256 a, uint256 b)
    public
    pure
    returns (uint256)
{
    return a + b;
}
```

---

### 10. Add Item to Inventory
**File:** `AddItemToInventory.sol`

**Problem:** Write a contract that manages an inventory of items (name + price). Only the contract owner should be able to add items using a custom `onlyOwner` modifier.

**Solution:** Three key parts: (1) The `onlyOwner` modifier uses `require(msg.sender == owner)` to check that the caller is the deployer before executing the function body (`_`). (2) `addItemToInventory` pushes a new `Item` struct into the `inventory` array. (3) `getInventory` returns the full array and `clearInventory` uses `delete` to reset it. This demonstrates structs, dynamic arrays, modifiers, and access control in Solidity.

**Before:**
```solidity
function addItemToInventory(
    string memory _name,
    uint256 _price
) public onlyOwner {
    // TODO
}

modifier onlyOwner() {
    _;
}

function getInventory() public view returns (Item[] memory) {
    // TODO
}

function clearInventory() private onlyOwner {
    // TODO
}
```

**After:**
```solidity
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
```

---

### 11. Fix Transfer Token
**File:** `FixTransferToken.sol`

**Problem:** The ERC20 transfer function has bugs. A user with 20 coins cannot transfer 10 coins. Find and fix the errors.

**Solution:** There were two bugs in the `_transfer` function:

**Bug 1:** `fromBalance <= amount` should be `fromBalance >= amount`. The original check was reversed, meaning it only allowed transfers when the balance was LESS than the amount (which is the opposite of what we want).

**Bug 2:** `_balances[from] = amount - fromBalance` should be `_balances[from] = fromBalance - amount`. The subtraction was reversed, which would give incorrect (or overflowing) results.

**Before (Buggy):**
```solidity
require(
    fromBalance <= amount,        // BUG: should be >=
    "ERC20: transfer amount exceeds balance"
);
_balances[from] = amount - fromBalance;  // BUG: reversed subtraction
_balances[to] += amount;
```

**After (Fixed):**
```solidity
require(
    fromBalance >= amount,        // FIXED: balance must be >= amount
    "ERC20: transfer amount exceeds balance"
);
_balances[from] = fromBalance - amount;  // FIXED: correct subtraction
_balances[to] += amount;
```

---

### 12. Calculate Gas
**File:** `Gas.sol`

**Problem:** Calculate how much gas it costs to increment a state variable `c` by 1.

**Solution:** We use the built-in `gasleft()` function which returns the remaining gas at any point during execution. We capture `gasleft()` before and after the `++c` operation, then subtract to get the exact gas consumed. The result is ~5958 gas because modifying a storage slot (SSTORE) from a non-zero to a non-zero value costs 5000 gas, plus some overhead for the increment operation itself.

**Before:**
```solidity
function calculateGas() external returns(uint _gasUsed) {
    ++c;
}
```

**After:**
```solidity
function calculateGas() external returns(uint _gasUsed) {
    _gasUsed = gasleft();
    ++c;
    _gasUsed -= gasleft();
}
```
