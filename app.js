function (Contract) {
    var web3_instance;
    var instance;
    var accounts;

    function init(cb) {
        web3_instance = new Web3(
            (window.web3 && window.web3.currentProvider) ||
            new Web3.providers.HttpProvider(Contract.endpoint));

            accounts = web3.eth.accounts;

        var contract_interface = web3_instance.eth.contract(Contract.abi);
        instance = contract_interface.at(Contract.address);
        cb();
    }

    function getBalance() {
        instance.getBalance(function (error, result) {
            if(error){
                alert(error);
            }else{
                //set value in html
                $("#balance").html(result.toString());   // result is a number so use toString to convert to a string
            }
        });
    }

    function waitForReceipt(txHash, cb){
        web3_instance.eth.getTransactionReceipt(txHash, function(error, receipt){
            if(error){
                alert(error);
            }else if(receipt !== null){
                cb(receipt);
            }else{
                window.setTimeout(function(){
                    waitForReceipt(txHash, cb);   //RECURSIVE
                }, 5000);
            }
        });
    }



    function getResult(){
        instance.getLastFlip(accounts[0], function(error, result){
            if(!result){
                $("#result").html("You won!");
            }else{
                $("#result").html("You lost!");
            }
        });
    }

    function flip(){
        let val = parseInt($("#bet").val());    //value was string so we want to parse to number
        instance.flip.sendTransaction({from: accounts[0], gas: 100000, value: val}, function(error, txHash){
            if(error){
                alert(error);
            }else{
                waitForReceipt(txHash, function(receipt){
                    if(receipt.status === "0x1"){  //STATUS CODE IS HEXADECIMAL AND THAT VALUE IS 1. THREE EQUALS ALSO COMPARES TYPE
                        getResult();  // get result of winning or losing
                        getBalance(); // update balance after saying you won or lost
                    }else{
                        alert("Status: Fail")
                    }
                });
            }
        });
    }

    $(document).ready(function () {
        init(function () {
            getBalance();
        });
        $("#submit").click(function(){
            flip();
        });
    });
})(Contracts['CoinFlip']);
