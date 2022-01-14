// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Token{
    string private name;
    string private symbol;
    uint256 private decimals; // adet "1000" -> 1000 den sonra 9 sıfır eklenir.
    uint256 private totalSupply; // 1000_000_000_000 -> 9 basamak.

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowed;

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Transfer(address indexed from,address indexed to,uint256 value);

    constructor(){
        name = "Omer Token";
        symbol = "OTK";
        decimals = 9;
        totalSupply = 1000_000_000_000;
        balanceOf[msg.sender] = totalSupply;
    }

    // remix üzerinden msg.sender kullanılırak yeni hesaba token iletimi sağlanır.
    function transfer(address _to,uint256 _value) external returns(bool success){
        require(balanceOf[msg.sender] >= _value); // göndericek yeterli token var mı kontrol
        require(_to != address(0));
        balanceOf[msg.sender] -= (_value);
        balanceOf[_to] += (_value);
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    // dinamik bir şekilde hesaptan hesaba token aktarımı gerçekleştirir.
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balanceOf[_from] >= _value);
        balanceOf[_from] -= (_value);
        balanceOf[_to] += (_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    // çekilebilicek token sayısını sınırlar
    function approve(address _spender, uint256 _value) public returns (bool success) { 
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // önce approve kullanılır, ardından ne kadar token göndermesine izin verdiğine bakabiliriz
    function allowance(address _owner, address _spender) public view returns (uint256) { 
        return allowed[_owner][_spender];
    }

}

// 0x<firstAccount> sender
// 0x<secendAccount> receiving(sınırlandırılan)
// sınırlandırma veririsek <approve -> allowance> sınırlandırılan değerden daha fazla girerse hata fırlatır
