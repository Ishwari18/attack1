// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "./interfaces/ICurveFi.sol";
import "./interfaces/ICurveRegistryExchange.sol";

contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {
    using SafeMath for uint256;
    event Log(address asset, uint256 val);

    constructor(address _addressProvider)
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {}

    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        emit Log(asset, IERC20(asset).balanceOf(address(this)));

        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        //get seth 
        //exchaneg functin 


        //depsit in lendlfare
        //lendmarket.depsit 
        //mak sure u enable the depsit t be used as cllarateral


        //add a huge liquidit in curve finance pl whse tken is ecrv
        //curve pl.add_liquidity 


        //remve it 
        //curve pl.remve_liqudity_imablance


        //then brr waginst ur clalteral in lendflare
        //fall back functin shuld brrw all the eht liquidity against seth 
        //this fall back fucntin witll be alled by curve's remve liquidity functin but will d the jb f brrwing frm lendflare
        


        // Approve the Pool contract allowance to *pull* the owed amount
        uint256 amountOwed = amount.add(premium);
        IERC20(asset).approve(address(POOL), amountOwed);
        emit Log(asset, IERC20(asset).balanceOf(address(this)));
        return true;
    }

     function addLiquidityCurve(
        address curvePool,
        address token,
        uint256 amount,
        uint256 depositAmount
    ) internal {
        IERC20(token).approve(curvePool, amount);
        uint256[3] memory curveAmounts1 = [0, depositAmount, 0];
        ICurveFi(curvePool).add_liquidity(curveAmounts1, 0);
    }
}
