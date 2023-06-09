// This is a file copied from https://github.com/aave/aave-v3-core/blob/e46341caf815edc268893f4f9398035f242375d9/contracts/interfaces/IPool.sol
// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.4;

import {ILendingPoolAddressesProvider} from "./ILendingPoolAddressesProvider.sol";
import {ILendingPool} from "./ILendingPool.sol";

/**
 * @title IFlashLoanReceiver interface
 * @notice Interface for the Aave fee IFlashLoanReceiver.
 * @author Aave
 * @dev implement this interface to develop a flashloan-compatible flashLoanReceiver contract
 **/
interface IFlashLoanReceiver {
    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external returns (bool);

    function ADDRESSES_PROVIDER()
        external
        view
        returns (ILendingPoolAddressesProvider);

    function LENDING_POOL() external view returns (ILendingPool);
}