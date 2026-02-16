// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoTrader {
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
}
