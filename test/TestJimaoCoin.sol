pragma solidity >=0.4.25 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/JimaoCoin.sol";

contract TestJimaoCoin {

  function testInitialBalanceUsingDeployedContract() public {
    JimaoCoin jimao = JimaoCoin(DeployedAddresses.JimaoCoin());

    uint expected = 10000;

    Assert.equal(jimao.getBalance(tx.origin), expected, "Owner should have 10000 JimaoCoin initially");
  }

  function testInitialBalanceWithNewJimaoCoin() public {
    JimaoCoin jimao = new JimaoCoin();

    uint expected = 10000;

    Assert.equal(jimao.getBalance(tx.origin), expected, "Owner should have 10000 JimaoCoin initially");
  }

}
