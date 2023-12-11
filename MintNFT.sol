// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MintNFT is ERC1155, Ownable {
    string public name;
    string public symbol;
    string metadataURI;
    uint lastTokenId;

    string notRevealedURI;
    bool isRevealed;

    constructor(string memory _name, string memory _symbol, uint _lastTokenId, string memory _notRevealedURI) ERC1155("") Ownable(msg.sender) {
        name = _name;
        symbol = _symbol;
        lastTokenId = _lastTokenId;
        notRevealedURI = _notRevealedURI;
    }

    function mintNFT(uint _tokenId, uint _amount) public {
        require(_tokenId <= lastTokenId && _tokenId != 0, "Not exist token ID.");

        _mint(msg.sender, _tokenId, _amount, "");
    }

    function uri(uint _tokenId) public override view returns(string memory) {
        if(!isRevealed){
            return notRevealedURI;
        }

        return string(abi.encodePacked(metadataURI, "/", Strings.toString(_tokenId), ".json"));
    }

    function setMetadataURI(string memory _metadataURI) public onlyOwner {
        metadataURI = _metadataURI;
    }

    function reveal() public onlyOwner {
        isRevealed = true;
    }
}