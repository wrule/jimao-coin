pragma solidity >=0.4.25 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/JimaoCoin.sol";

contract TestMetaCoin {

  function testInitialBalanceUsingDeployedContract() public {
    JimaoCoin meta = JimaoCoin(DeployedAddresses.JimaoCoin());

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 JimaoCoin initially");
  }

  function testInitialBalanceWithNewMetaCoin() public {
    JimaoCoin meta = new JimaoCoin();

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 JimaoCoin initially");
  }

}
