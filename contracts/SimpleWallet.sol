// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract SimpleWallet {
    event Received(address, uint);
    
    function withdrawMoney(address payable _to, uint _amount) public {

    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback () external payable {}
}
