// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {


    uint256 public rate = 1000;
    uint fixedSupply = 1000000 * 10 ** 18;


    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address receiver) public  payable{
        require(msg.value > 0, "Insufficient token");
        uint boughtToken = msg.value * rate;
        
        require(fixedSupply >= totalSupply() + boughtToken, "Must not exceed fixed supply");
        _mint(receiver,boughtToken);

    }
}