// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./OnChainMetadata.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev The tokenURI() and contractURI() methods are responsible to call _createTokenURI() and _createContractURI() methods
 * of OnChainMetadata contract, which convert metadata into a Base64-encoded json readable by OpenSea, LooksRare and many other NFT platforms.
 */
abstract contract ERC721OnChainMetadata is ERC721, OnChainMetadata {
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(_exists(tokenId), "tokenId doesn't exist");
        return _createTokenURI(tokenId);
    }

    function contractURI() public view virtual returns (string memory) {
        return _createContractURI();
    }
}