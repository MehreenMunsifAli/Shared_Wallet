# Shared_Wallet

This contract allows for seamless management of shared funds between an owner and allowed users. 
Here's how it works:

**1- Setting Allowance:** The contract owner can set an allowance for specific users, determining how much they're permitted to withdraw.

**2- Withdraw Funds:** Both the owner and allowed users can withdraw funds from the wallet. The owner has no withdrawal limits, while allowed users' allowances are reduced with each withdrawal.

**3- Reducing Allowance:** The owner has the power to reduce a user's allowance if needed.

**4- Contract Balance:** You can easily check the current balance of the contract.

**5- Event Emission:** The contract emits events for money sent and received, allowing for transparent tracking of transactions.

Explore the code to see how this all comes together. Feel free to use and adapt this smart contract for your own use cases! 👩‍💻👨‍💻
