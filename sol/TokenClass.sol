pragma solidity 0.4.24;

import "./StandardToken.sol";
import "./Ownable.sol";

contract OleCoin is StandardToken, Ownable {

    event tokenComprado(address comprador);
    
    
    string public constant name = "OleProjectv7";
    string public constant symbol = "Ole";
    uint8 public constant decimals = 18;
    
    uint256 public constant INITIAL_SUPPLY = 150000000 * (10 ** uint256(decimals));
    
    event tokenBought(address adr);
    
    uint256 public tokenPrice;    

    constructor() public payable{
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);
        tokenPrice = 100000000000000 wei;
    }
    
    function() public payable {
       /* require(msg.value > 0);
        _qtd = (msg.value / tokenPrice);      
        balances[owner] = balances[owner].sub(_qtd);
        balances[msg.sender] = balances[msg.sender].add(_qtd);
        address(this).transfer(msg.value);
        emit Transfer(owner, msg.sender, _qtd); 
        //comprarTokens(msg.value);    */  
        emit tokenComprado(msg.sender);
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function setPrice(uint256 _priceToken) public onlyOwner {
        tokenPrice = _priceToken;
    }
    function saque() public onlyOwner {
        address(owner).transfer(getBalance());
    }

    function kill() public onlyOwner {
        selfdestruct(owner);
    }
        
    function comprarTokens(uint256 qtd) public payable {
        require(qtd > 0);
        require(msg.value > 0);
        require(msg.value == (qtd * tokenPrice));
        qtd = qtd * (10 ** uint256(decimals));
        balances[owner] = balances[owner].sub(qtd);
        balances[msg.sender] = balances[msg.sender].add(qtd);
        address(this).transfer(msg.value);
        emit Transfer(owner, msg.sender, qtd);
    }
    
}