 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./FirstErc20.sol";

// price = 100000000000000000 wei d'ether (0.1 ether)
contract CALKIco {
    // Declare a FirstErc20 contract
    FirstErc20 public token;

    // The price of 1 token in wei;
    uint256 public price;

    // Address of token seller
    address payable private _seller;

    uint256 private _decimal;

    constructor(
        uint256 _price, // price pour 1 CALCK 0.1 Ether 100000000000000000
        address payable seller, 
        address erc20Address
    ) public {
        price = _price;
        _seller = seller;
        token = FirstErc20(erc20Address);
        _decimal = (10**uint256(token.decimals()));
    }

    function getCurrentPrice() public view returns (uint256) {
        return price;
    }

    function getPricePerNbTokens(uint256 nbTokens) public view returns (uint256) {
        uint256 buyPrice = (nbTokens * price) / _decimal;
        require(buyPrice > 0, "CALKIco: Need a higher number of tokens");
        return buyPrice;
    }

    function getNbTokensPerPrice(uint256 _buyPrice) public view returns (uint256) {
        uint256 nbTokens = (_buyPrice * _decimal) / price;
        require(nbTokens > 0, "CALKIco: Need a higher amount of ether for buying tokens");
        return nbTokens;
    }

    receive() external payable {
        buy(getNbTokensPerPrice(msg.value));
    }

    // nbTokens en wei de CALC 
    function buy(uint256 nbTokens) public payable returns (bool) {
        // check if ether > 0
        require(msg.value > 0, "ICO: purchase price can not be 0");
        // check if nbTokens > 0
        require(nbTokens > 0, "ICO: Can not purchase 0 tokens");
        // check if enough ethers for nbTokens
        require(msg.value >= getPricePerNbTokens(nbTokens), "ICO: Not enough ethers for purchase");
        uint256 _realPrice = getPricePerNbTokens(nbTokens);
        uint256 _remaining = msg.value - _realPrice;
        token.transferFrom(_seller, msg.sender, nbTokens);
        _seller.transfer(_realPrice);
        if (_remaining > 0) {
            msg.sender.transfer(_remaining);
        }
        return true;
    }
}

