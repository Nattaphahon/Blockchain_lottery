// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test_Lottery{
    address manager;
    address payable[] players;

    constructor(){
        manager = msg.sender;
    }
    //เช็คยอดขาย
    function getBalance() public view returns(uint){
            return address(this).balance;
    }
    //ซื้อLottery
    function buyLottery() public payable{
        require(msg.value == 0.001 ether,"0.001 ETH per 1 ticket");
        players.push(payable(msg.sender));
    }
    //เช็คจำนวนที่ขายได้
    function getLength() public view returns(uint){
        return players.length;
    }
    //สุ่มเลข
    function randomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }
    function selectWinner() public{
        require(msg.sender == manager,"You aren't manager");
        require(getLength()>=3,"less then 3 tickets");
        uint pickrandom = randomNumber();
        address payable winner;
        uint selectIndex = pickrandom % players.length;
        winner = players[selectIndex];
        winner.transfer(getBalance());
        players = new address payable[](0);
    }
}