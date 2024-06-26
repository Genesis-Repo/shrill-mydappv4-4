// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LoyaltyApp is Ownable {
    IERC20 public token;
    mapping(address => uint256) public loyaltyPoints;

    event LoyaltyPointsEarned(address indexed user, uint256 points);
    event LoyaltyPointsRedeemed(address indexed user, uint256 points);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function earnLoyaltyPoints(uint256 _points) external {
        require(_points > 0, "Points should be greater than 0");
        loyaltyPoints[msg.sender] += _points;
        emit LoyaltyPointsEarned(msg.sender, _points);
    }

    function redeemLoyaltyPoints(uint256 _points) external {
        require(_points > 0, "Points should be greater than 0");
        require(loyaltyPoints[msg.sender] >= _points, "Insufficient loyalty points");
        
        loyaltyPoints[msg.sender] -= _points;
        // Implement redemption logic here
        emit LoyaltyPointsRedeemed(msg.sender, _points);
    }
}