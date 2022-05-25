// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TokenData.sol";
import "./CustomERC20.sol";

contract ERC20Factory {
    mapping(address => Token[]) private createdTokens;

    event Created(string _name, string _symbol, string _tokenType);

    function create(string memory name_, string memory symbol_, bool isBurnable_, bool isMintable_, uint256 initialSupply_) external returns (bool) {
        // Spin up new ERC20 token
        new CustomERC20(name_, symbol_, isBurnable_, isMintable_, initialSupply_);

        // Save token data
        address sender = msg.sender;
        Token[] storage tokens = createdTokens[sender];
        tokens.push(Token(name_, symbol_, "ERC20", isBurnable_, isMintable_));
        createdTokens[sender] = tokens;

        // Emit and retuen
        emit Created(name_, symbol_, "ERC20");
        return true;
    }

    function getAll() public view returns(Token[] memory)
    {
        address sender = msg.sender;
        Token[] memory tokens = createdTokens[sender];
        return tokens;
    }
}