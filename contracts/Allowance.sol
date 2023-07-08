// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance is Ownable {

    event AllowanceChanged(address indexed _from, address indexed _toWhom, uint256 _oldAmount, uint256 _newAmount);

    mapping(address => uint256) public allowance;

    bool isAllowanceSet;

    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        require(
            isAllowanceSet ==  false,
            "Allowance Already Set"
        );
        emit AllowanceChanged(msg.sender, _who, allowance[_who], _amount);
        allowance[_who] = _amount;
        isAllowanceSet = true;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You're not allwoed"
        );
        _;
    }

    function _reduceAllowance(address _who, uint256 _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(msg.sender, _who, allowance[_who], allowance[_who] - _amount);
        if (isAllowanceSet) {
        allowance[_who] -= _amount;
        } else {
            revert ("Allowance not set");
        }
    }

    function increaseAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(msg.sender, _who, allowance[_who], allowance[_who] + _amount);
        if (isAllowanceSet) {
        allowance[_who] += _amount;
         } else {
            revert ("Allowance not set");
        }
    }
}

