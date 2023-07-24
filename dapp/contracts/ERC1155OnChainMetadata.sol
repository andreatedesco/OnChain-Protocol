// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./OnChainMetadata.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev The uri() and contractURI() methods are responsible to call _createTokenURI() and _createContractURI() methods
 * of OnChainMetadata contract, which convert metadata into a Base64-encoded json readable by OpenSea, LooksRare and many other NFT platforms.
 */
abstract contract ERC1155OnChainMetadata is ERC1155, OnChainMetadata {
    function uri(
        uint256 tokenId
    ) public view virtual override(ERC1155) returns (string memory) {
        return _createTokenURI(tokenId);
    }

    function contractURI() public view virtual returns (string memory) {
        return _createContractURI();
    }
}
