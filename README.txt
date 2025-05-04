My Life on the Blockchain: A Decentralized Todo List ✨
Welcome to the ultimate task manager, powered by Solidity! This smart contract isn't just any todo list; it's a decentralized, tamper-resistant record of my daily grind as a 21-year-old navigating classes, coding bootcamps, and the quest for new skills. Built as part of the Lisk Africa Developer's Bootcamp Week 3 assignment, this contract demonstrates core Solidity concepts while keeping my life (mostly) in order.

🚀 What's Inside? (Features)
This contract lets you manage tasks with that blockchain magic. Here's what it can do:

Task Management: Add, update the status or content of, and "delete" tasks.

Task Retrieval: Get details for a specific task or fetch the entire list.

Count: See the total number of tasks added.

🧠 The Brains Behind the Operation (Solidity Concepts)
We're flexing some key Solidity muscles here, using:

Enums (TodoStatus): For clear task states.

Structs (Todo): To structure task data.

Mappings (todos): For quick lookups.

Arrays (todoIds): To track task order.

Events: To signal important actions.

View vs. State-Changing Functions: Understanding gas costs.

📋 The Daily Grind (Realistic Todo List)
The contract comes pre-loaded with a realistic (and slightly chaotic) daily routine for a 21-year-old, including:

Morning routine essentials

Attending classes

Dedicated coding time (4 hours grind!)

Lisk Africa Bootcamp class (6-7 PM, gotta level up!)

Learning a new skill

Screen time / Off-screen time balance

...and the eternal struggle with the snooze button.

It's a peek into the life, coded!

🛠️ How to Use (Getting Started)
This contract is designed to be deployed on a blockchain network. For this assignment, it's intended for the Lisk Testnet.

Get the Code: Copy the TodoList.sol code.

Choose Your Environment:

Remix IDE: Easiest for quick testing. Paste the code, compile, and deploy using the "Injected Provider" environment connected to the Lisk Testnet (ensure you have a wallet like MetaMask configured for it).

Hardhat/Truffle: For more robust development and deployment scripting. Set up your project, configure it for the Lisk Testnet, compile, and run your deployment script.

Deploy: Deploy the compiled contract to the Lisk Testnet. You'll need some testnet LSK to cover gas fees.

Interact: Once deployed, you can interact with the contract's functions using:

The interface in Remix (if you deployed via Remix).

A dApp frontend you build that connects to the Lisk Testnet.

Web3 libraries (like ethers.js or web3.js) in a script.

You can call functions like addTodo("Go grocery shopping"), updateStatus(0, 2) (where 0 is the todo ID and 2 is Completed), getTodo(0), getAllTodos(), etc.

👋 How to Contribute (Keepin' it Real)
This is a basic assignment contract, but contributions are always welcome!

Found a bug? Open an issue and let me know what went wrong.

Have a suggestion? Maybe a more efficient way to do something, or an idea for a new feature (like sorting todos)? Open an issue or a pull request!

Code Review: If you see something that could be improved or a potential vulnerability (though this is simple!), your feedback is super valuable.

Let's make it better together!

📜 License
This project is licensed under the MIT License. See the LICENSE file for details (Note: The contract code itself uses // SPDX-License-Identifier: MIT).

Built with vibes and Solidity for the Lisk Africa Developer's Bootcamp Week 3. Let's get this bread (and check off those todos)! 