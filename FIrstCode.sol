pragma solidity ^0.4.0;


contract Person{
    struct persons{
        string name;
        uint age;
    }
    
    persons [] people;
    
    function addPerson(string _name, uint _age){
        people.push(persons(_name, _age));
    }
    
    function getAverageAge() returns (uint){
        uint i;
        uint sum =0;
        uint total =0;
        for(i =0; i<people.length; i++){
            sum += people[i].age;
            total++;
        }
        return (sum/total);
    }
    
    
    
    
}