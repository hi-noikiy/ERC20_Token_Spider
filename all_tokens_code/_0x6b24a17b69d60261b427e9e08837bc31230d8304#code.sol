//token_name	
//token_url	https://etherscan.io//address/0x6b24a17b69d60261b427e9e08837bc31230d8304#code
//spider_time	2018/07/08 12:23:11
//token_Transactions	3 txns
//token_price	

pragma solidity ^0.4.18;


contract TEMTicket {
    uint256 constant public FEE = 0.015 ether;

    mapping (uint256 => address) public id2Addr;
    mapping (address => uint256) public userId;
    address public TEMWallet;
    uint256 public userAmount;
    uint256 public maxAttendees;
    uint256 public startTime;

    function TEMTicket(address _TEMWallet, uint256 _maxAttendees, uint256 _startTime) public {
        TEMWallet = _TEMWallet;
        maxAttendees = _maxAttendees;
        userAmount = 0;
        startTime = _startTime;
    }

    function () payable external {
        getTicket(msg.sender);
    }

    function getTicket (address _attendee) payable public {
        require(now >= startTime && msg.value >= FEE && userId[_attendee] == 0);
        userAmount ++;
        require(userAmount <= maxAttendees);
        userId[_attendee] = userAmount;
        id2Addr[userAmount] = _attendee;
    }

    function withdraw () public {
        TEMWallet.transfer(this.balance);
    }
}