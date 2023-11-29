// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "./AginERC-1155.sol";



contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    address public tokenContract; // Address of the ERC-20 token contract

    // Constructor
    constructor(address payable _tokenContract) ERC721("MyNFT", "MNFT") {
        tokenContract = _tokenContract;
    }

   

    // Modifier to check if the sender has at least 100 tokens
    modifier hasRequiredTokens() {
        require(ERC20(tokenContract).balanceOf(msg.sender) >= 1000 * (10**18), "Insufficient tokens");
        _;
    }

    // Add this function to your ERC721 contract
   

    // Mint function - requires 100 ERC-20 tokens
    function mintNFT(string memory tokenURI) public payable hasRequiredTokens returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdCounter.increment();
        return tokenId;
    }

    // Set or update token URI function
    function setTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _setTokenURI(tokenId, tokenURI);
    }
}

