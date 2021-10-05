// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Album is ERC721{
    constructor (uint256 price) public  ERC721("Drew","Rapper") {
        _mint(msg.sender,price);
    }

mapping(address => uint) tokens;
// Mapping from token ID to owner address
mapping(uint256 => address) public _owners;

// Mapping owner address to token count
mapping(address => uint256) public _balances;

function approval(address _owner, address _approved,uint _tokenId)public {
require(tokens[_owner]==_tokenId);
tokens[_approved]=_tokenId;
}
function transfer(address _to, uint _amount) public payable{
require(_amount <= tokens[msg.sender]);
tokens[msg.sender]-=_amount;
tokens[_to]+=_amount;
}
function balanceOf(address _owner) public view override returns (uint){
return tokens[_owner];
}

function ownerOf(uint256 tokenId) public view virtual override returns (address) {
address owner = _owners[tokenId];
require(owner != address(0), "ERC721: owner query for nonexistent token");
return owner;
}
function TransferFrom(address _from, address _to, uint _tokenId) public payable{
require(tokens[_from]==_tokenId);
tokens[_from]=0;
tokens[_to]=_tokenId;
}

function approve(address to, uint256 tokenId) public virtual override {
address owner = ERC721.ownerOf(tokenId);
require(to != owner, "ERC721: approval to current owner");
require( _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
"ERC721: approve caller is not owner nor approved for all");
_approve(to, tokenId);
}

function mint(address to, uint _tokenId) public{
require(to != address(0), "ERC721: mint to the zero address");
_balances[to] += 1;
_owners[_tokenId] = to;
emit Transfer(address(0), to, _tokenId);

}
}
