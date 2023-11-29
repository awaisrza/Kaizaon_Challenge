// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20 {
    // The total supply of tokens
    uint256 public constant TOTAL_SUPPLY = 5000 * (10**18); // 18 decimal places


    
    // The contract creator will receive all initial tokens
    constructor() ERC20("KaizanToken", "KAZ")  {
        _mint(msg.sender, TOTAL_SUPPLY);
    }
   

     function burn(uint256 amount)  public {
        _burn(msg.sender, amount);
    }

}
