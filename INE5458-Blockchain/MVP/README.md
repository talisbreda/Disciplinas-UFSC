# This is the MVP for the FraudReport project

This MVP consists of a website and a Truffle project that hosts a smart contract. The website allows users to submit a report of fraud and the smart contract stores the report on the blockchain.

## Requirements to run
- Node.js
- Truffle
- Some provider of an Ethereum node (e.g. Ganache)

## How to run

!!! DISCLAIMER: Do not close the terminal during the following process, as it contains important information. Closing it after step 7 will require it to be run again from step 7 !!!

1. run `cd site`
2. run `npm install`
3. run `cd ../Truffle-project`
4. run `npm install`
5. run `npx truffle compile` or `truffle compile`
6. Run your local Ethereum node (e.g. Ganache) and make sure it is running on port 7545
7. run `npx truffle migrate` or `truffle migrate`
8. DO NOT CLOSE THE TERMINAL
9. Find the address of the deployed contract in the terminal
10. Go to `/site/index.html` and find line 198
11. Replace the address in line 198 with the address of the deployed contract
12. Find the address of the account in the terminal
13. Still on `index.html`, find line 155
14. Replace the address in line 155 with the address of the account
15. Go to line 181 on `index.html` and replace the URL with the URL of your local Ethereum node
16. Open `index.html` in your preffered way (browser, live server, etc.)
17. Scroll down
18. Choose a company, type a feedback and press submit
