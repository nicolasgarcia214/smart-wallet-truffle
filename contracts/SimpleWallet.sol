// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract SimpleWallet {
    event Received(address, uint);
    uint public totalBalance;
    address public owner;

    mapping (address=>uint) public allowance;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    modifier ownerOrAllowed(uint _amount) {
        require((owner == msg.sender) || (allowance[msg.sender] >= _amount), "You are not allowed");
        _;
    }

    function setAllowance(address _who, uint _amount) public onlyOwner{
        allowance[_who] = _amount;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        totalBalance -= _amount;
        _to.transfer(_amount);
    }

    receive() external payable {
        totalBalance += msg.value;
        emit Received(msg.sender, msg.value);
    }

    fallback () external payable {
        totalBalance += msg.value;
    }
}
