//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.4;

// import "@openzeppelin/contracts/interfaces/IERC20.sol";
import {IFlashLoanReceiver} from "./IFlashLoanReceiver.sol";
import {ILendingPoolAddressesProvider} from "./ILendingPoolAddressesProvider.sol";
import {ILendingPool} from "./ILendingPool.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
    using SafeMath for uint256;

    ILendingPoolAddressesProvider public immutable override ADDRESSES_PROVIDER;
    ILendingPool public immutable override LENDING_POOL;

    constructor(ILendingPoolAddressesProvider provider) {
        ADDRESSES_PROVIDER = provider;
        LENDING_POOL = ILendingPool(provider.getLendingPool());
    }
}