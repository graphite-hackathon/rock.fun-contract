// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; // To make the deployer the owner

contract GemERC20 is ERC20, Ownable {
    uint8 private _customDecimals;

    constructor(
        string memory name,
        string memory symbol,
        uint8 customDecimalsValue,
        uint256 alreadyScaledInitialSupply, // This is nominalSupply * (10**customDecimalsValue)
        address initialHolder // The user deploying the contract
    ) ERC20(name, symbol) Ownable(initialHolder) { // Set deployer as owner
        require(customDecimalsValue <= 50, "Decimals must be 0-50"); // Practical limit for decimals
        _customDecimals = customDecimalsValue;
        _mint(initialHolder, alreadyScaledInitialSupply); // Mint all tokens to the deployer
    }

    function decimals() public view virtual override returns (uint8) {
        return _customDecimals;
    }
}