// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply; // 1000000000000000000 -> 18 decimals.

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _decimals,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value)
        external
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value); // göndericek yeterli token var mı kontrol
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) internal {
        require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }
}
