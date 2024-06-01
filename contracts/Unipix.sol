//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Unipix is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    constructor(
        address _owner,
        string memory _dataURI
    ) ERC404("Unipix", "UNIPIX", 18, 10000, _owner) {
        balanceOf[_owner] = 10000 * 10 ** 18;
        dataURI = _dataURI;
    }

    function setDataURI(string memory _dataURI) public onlyOwner {
        dataURI = _dataURI;
    }

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setNameSymbol(
        string memory _name,
        string memory _symbol
    ) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
            string memory image;
            string memory location;

            if (seed <= 100) {
                image = "1.png";
                location = "GreenSprout";
            } else if (seed <= 160) {
                image = "2.png";
                location = "EcoGrow";
            } else if (seed <= 210) {
                image = "3.png";
                location = "Argofera";
            } else if (seed <= 240) {
                image = "4.png";
                location = "Nexagri";
            } else if (seed <= 255) {
                image = "5.png";
                location = "FutureFarm Haven";
            }

            string memory jsonPreImage = string.concat(
                string.concat(
                    string.concat('{"name": "Unipix #', Strings.toString(id)),
                    '","description":"An exclusive NFT collection enabled by ERC404, offering 10,000 parcels of land from advanced agricultural sites. Each NFT represents a unique piece of these innovative locations, each distinguished by its own technology and vision for sustainable agriculture.","external_url":"https://github.com/harundarat","image":"'
                ),
                string.concat(dataURI, image)
            );
            string memory jsonPostImage = string.concat(
                '","attributes":[{"trait_type":"Location","value":"',
                location
            );
            string memory jsonPostTraits = '"}]}';

            return
                string.concat(
                    "data:application/json;utf8,",
                    string.concat(
                        string.concat(jsonPreImage, jsonPostImage),
                        jsonPostTraits
                    )
                );
        }
    }
}
