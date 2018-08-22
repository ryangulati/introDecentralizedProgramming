pragma solidity ^0.4.0;

import './Ownable.sol';

contract DogContract is Ownable{
    
    struct Dog{
        string name;
        uint age;
    }
    
    Dog[] dogs;
    mapping(address => uint) ownerToDog;
    
    
    function addDog(string _name, uint _age) internal{
        address owner = msg.sender;   //variable owner holds an eth address  (owner of the contract when first deployed)
        uint id = dogs.push(Dog(_name, _age));  //or Dog newdog = Dog(_name, _age);  dogs.push(newdog);
        ownerToDog[owner] = id;
    }
    
    function getDog() returns (string){
        address owner = msg.sender;
        uint id= ownerToDog[owner];
        return dogs[id-1].name;
    }
}