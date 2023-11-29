// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./KaizanNFT.sol";
contract NFTBridge is ERC1155, Ownable {
    IERC721 public erc721Token;

    constructor(address payable _erc721Token) ERC1155("https://myapi.com/api/token/{id}.json") {
        erc721Token = IERC721(_erc721Token);
    }

    function mint(uint256 tokenId, uint256 amount) external payable {
        // Ensure the caller owns the ERC721 token
        require(erc721Token.ownerOf(tokenId) == msg.sender, "Not the owner of ERC721 token");

        // // Burn the ERC721 token
         erc721Token.transferFrom(msg.sender, address(0), tokenId);
        
        // Mint the ERC1155 tokens
        _mint(msg.sender, tokenId, amount, "");
    }

   
}



