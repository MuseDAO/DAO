pragma solidity ^0.5.0;

// Import interface for ERC20 standard
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "./APIConsumer.sol";

contract daiTips is ChainlinkClient {

// Retrieve LendingPool address
LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8)); // mainnet address, for other addresses: https://docs.aave.com/developers/developing-on-aave/deployed-contract-instances

function requestEthereumPrice() public onlyOwner {
	Chainlink.Request memory req = buildChainlinkRequest("e5672029986e4cb793c88433c7d7b953", address(this), this.fulfill.selector);
	req.add("get", "");
	req.add("path", "USD");
	req.addInt("times", 100);
	sendChainlinkRequestTo(ORACLE_ADDRESS, req, ORACLE_Payments);
}

// Input variables
address daiAddress = address(0x6B175474E89094C44Da98b954EedeAC495271d0F); // mainnet DAI
uint256 amount = 1000 * 1e18;
address onBehalfOf = msg.sender;
uint16 referralCode = 0;

// Approve LendingPool contract to move your DAI
IERC20(daiAddress).approve(address(lendingPool), amount);

// Deposit 1000 DAI
lendingPool.deposit(asset, amount, onBehalfOf, referralCode);
}