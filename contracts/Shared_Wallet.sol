// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Allowance.sol";

contract Shared_Wallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);


// @dev  owner and allowed users can withdraw money. owner has access to withdraw unlimited amount but allowed users allowance will be reduced. 
// @param  adress to whom user want to send money (user's own account or other account)
// @param  amount to be withdrawn
// emits MoneySent event.

  function withdrawMoney(
      address payable _to, 
      uint256 _amount
      ) public payable ownerOrAllowed(_amount) {
        require(
            _amount <= address(this).balance,
            "Contract out of money"
        );
        if(!isOwner()) {
            _reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
       
    }

// @dev  this can only be called by the owner if he wants to reduce the allowance of a user.
// **  called the internal function from 'Allowance.sol' to make it callable by the owner externally.

    function reduceAllowance(
        address _who, 
        uint256 _amount
        ) public onlyOwner {
        super._reduceAllowance(_who, _amount);
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function getContractBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

     function renounceOwnership() public override virtual onlyOwner {
        revert("can't renounce ownership"); // overrided the renounceOwnership in Ownable.sol
    }
}    