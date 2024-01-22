// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import{ERC721} from  "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import{Base64} from  "@openzeppelin/contracts/utils/Base64.sol";




contract Drive is ERC721{
    string private s_ClassicCarImageURI;
    string private s_SportsCarImageURI;
    uint256 private s_TokenId;

    enum Cars{

        Classic,
        Sports
    }

    mapping (uint256 tokenId => Cars car) private idToCar;

    constructor(string memory _classicCarUri, string memory _sportsCarUri) ERC721("DRIVE","DRV"){
        s_ClassicCarImageURI = _classicCarUri;
        s_SportsCarImageURI = _sportsCarUri;
        s_TokenId = 0;

    }

    function mint() public {
        uint256 tokenId = s_TokenId;
        _safeMint(msg.sender, tokenId);
        s_TokenId = s_TokenId+1;

    }


    function changeCar(uint256 tokenId) public{

        if(idToCar[tokenId] == Cars.Classic){
            idToCar[tokenId] = Cars.Sports;
        }else{
            idToCar[tokenId] = Cars.Classic;
        }
    }



    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }



    function tokenURI(uint256 tokenId) public virtual override view returns (string memory) {
            string memory imageURI = s_SportsCarImageURI;

        if(idToCar[tokenId] == Cars.Classic ){
                imageURI = s_ClassicCarImageURI;
                  return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"Classic Car"',
                            '", "description":"Amazing Claasic Car For Driving With Family!", ',
                            '"attributes": [{"trait_type": "Max Speed", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
     return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"Sports Car"',                        
                            '", "description":"Amazing Sports Car For Driving With Friends", ',
                            '"attributes": [{"trait_type": "Max Speed", "value": 250}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function getTokenId() public view returns(uint256){
        return s_TokenId;
    }

    function getClassicCarImageUri() public view returns(string memory){
        return s_ClassicCarImageURI;
    }

    function getSportsCarImageUri() public view returns(string memory){
        return s_SportsCarImageURI;
    }
    
}