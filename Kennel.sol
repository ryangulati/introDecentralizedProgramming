pragma solidity^0.4.0;
import "./DogContract.sol";



contract BankInterface{
    function getBalance() view returns (uint);
    function deposit() payable;
}


contract Kennel is DogContract {  //also inherits is ownable from DogContract
    
    modifier costs(uint value){
        require(msg.value >= 100);
        _;
    }
    
   
    BankInterface BankContract;
    
    function initBankContract (address _bankAddress) onlyOwner{
        BankContract = BankInterface(_bankAddress);
    }
    
    function transferDog(address _newOwner) payable costs(100){
        address owner = msg.sender;
        require(owner != _newOwner);
        uint dogId = ownerToDog[owner];
        delete(ownerToDog[owner]);
        ownerToDog[owner] = dogId;
        BankContract.deposit.value(msg.value)(); // not sure about this line of code -- unclear
    }
    
    function addKennelDog(string _name, uint _age){
        addDog(_name,  _age);
    }
}