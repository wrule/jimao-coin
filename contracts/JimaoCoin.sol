// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract JimaoCoin {
	// 地址余额HashMap
	mapping (address => uint) balances;

	// 事件声明
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Log(string text);

	// 构造函数
	// 给tx.origin充值10000个币
	constructor() public {
		balances[tx.origin] = 10000;
	}

	// 发送币到某一个账户
	function sendCoin(address receiver, uint amount)
	public returns(bool sufficient)
	{
		if (balances[msg.sender] < amount) {
			return false;
		}
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	// 获取某个账户下ETH表示的余额
	function getBalanceInEth(address addr)
	public view returns(uint)
	{
		return ConvertLib.convert(getBalance(addr), 2);
	}

	// 获取某个账户下的余额
	function getBalance(address addr)
	public view returns(uint)
	{
		return balances[addr];
	}

	function helloWorld()
	public
	{
		emit Log("hello world");
	}

	function test()
	public
	{
		for (uint i = 0; i < 100; i++) {
			emit Log("hello world");
		}
	}
}
