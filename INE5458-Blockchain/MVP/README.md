# This is the MVP for the FraudReport project

This MVP consists of a website and a Truffle project that hosts a smart contract. The website allows users to submit a report of fraud and the smart contract stores the report on the blockchain.

## Requirements to run
- Node.js
- Truffle
- Some provider of an Ethereum node (e.g. Ganache)

## How to run

!!! DISCLAIMER: Do not close the terminal during the following process, as it contains important information. Closing it after step 4 will require it to be run again from step 4 !!!

1. run `cd site`
2. run `npm install`
3. run `cd ../Truffle-project`
4. run `npx truffle compile` or `truffle compile`
5. run `npx truffle migrate` or `truffle migrate`
6. DO NOT CLOSE THE TERMINAL
7. Find the address of the deployed contract in the terminal
8. Go to `/site/index.html` and find line 200
9. Replace the address in line 200 with the address of the deployed contract
10. Find the address of the account in the terminal
11. Still on `index.html`, find line 157
12. Replace the address in line 157 with the address of the account
13. Run your local Ethereum node (e.g. Ganache)
14. Go to line 181 on `index.html` and replace the URL with the URL of your local Ethereum node
15. Open `index.html` in your preffered way (browser, live server, etc.)
16. Scroll down
