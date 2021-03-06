const JimaoCoin = artifacts.require("JimaoCoin");

contract('JimaoCoin', (accounts) => {
  it('should put 10000 JimaoCoin in the first account', async () => {
    const jimaoCoinInstance = await JimaoCoin.deployed();
    const balance = await jimaoCoinInstance.getBalance.call(accounts[0]);

    assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
  });
  it('should call a function that depends on a linked library', async () => {
    const jimaoCoinInstance = await JimaoCoin.deployed();
    const jimaoCoinBalance = (await jimaoCoinInstance.getBalance.call(accounts[0])).toNumber();
    const jimaoCoinEthBalance = (await jimaoCoinInstance.getBalanceInEth.call(accounts[0])).toNumber();

    assert.equal(jimaoCoinEthBalance, 2 * jimaoCoinBalance, 'Library function returned unexpected function, linkage may be broken');
  });
  it('should send coin correctly', async () => {
    const jimaoCoinInstance = await JimaoCoin.deployed();

    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (await jimaoCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await jimaoCoinInstance.getBalance.call(accountTwo)).toNumber();

    // Make transaction from first account to second.
    const amount = 10;
    await jimaoCoinInstance.sendCoin(accountTwo, amount, { from: accountOne });

    // Get balances of first and second account after the transactions.
    const accountOneEndingBalance = (await jimaoCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await jimaoCoinInstance.getBalance.call(accountTwo)).toNumber();


    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
  });
});
