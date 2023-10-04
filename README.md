<h1 align="center"> OnChain Protocol </h1> 

OnChain Protocol is a set of Solidity contracts and libraries that enable on-chain metadata storage for ERC721 and ERC1155 contracts.


## Key Features

- On-Chain NFT Metadata Storage: The protocol allows for on-chain storage of metadata for NFT contracts. This eliminates the need for off-chain storage solutions and ensures data integrity and immutability.

- NFT URI Generation: The protocol provides functions to generate URIs compliant with official standards for [NFT contract metadata](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md). These URIs can be easily read by NFT marketplaces like OpenSea and Rarible.

- User-Friendly: The protocol is designed to be user-friendly. Basic contracts and libraries are provided that can be inherited or used as dependencies in ERC721 and ERC1155 contracts.


## The Project Structure

- [OnChainMetadataBuilder.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/OnChainMetadataBuilder.sol): This library provides functions for generating URIs for tokens and contracts based on provided metadata.

```solidity

    // create token URI formatted according to the official NFT metadata standards.
    function createTokenURI(
        bytes memory name,
        bytes memory description,
        bytes memory image,
        bytes memory external_url,
        bytes[] memory trait_type,
        bytes[] memory trait_value,
        bytes[] memory trait_display,
        bytes memory animation_url,
        bytes memory youtube_url,
        bytes memory background_color
    ) external pure returns (string memory) { (...) }

    // create contract URI formatted according to the official NFT metadata standards.
    function createContractURI(
        bytes memory name,
        bytes memory description,
        bytes memory image,
        bytes memory banner,
        bytes memory external_url
    ) external pure returns (string memory) { (...) }

```


- [OnChainMetadataStorage.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/OnChainMetadataStorage.sol): This library provides a structure for on-chain metadata storage. It contains all keys compliant with official standards for NFT contract metadata.

```solidity

    bytes32 constant key_contract_name = "name";
    bytes32 constant key_contract_description = "description";
    bytes32 constant key_contract_logo = "image";
    bytes32 constant key_contract_banner = "banner";
    bytes32 constant key_contract_external_link = "external_link";

    bytes32 constant key_token_name = "name";
    bytes32 constant key_token_description = "description";
    bytes32 constant key_token_image = "image";
    bytes32 constant key_token_animation_url = "animation_url";
    bytes32 constant key_token_external_url = "external_url";
    bytes32 constant key_token_background_color = "background_color";
    bytes32 constant key_token_youtube_url = "youtube_url";
    bytes32 constant key_token_attributes_trait_type = "trait_type";
    bytes32 constant key_token_attributes_trait_value = "trait_value";
    bytes32 constant key_token_attributes_display_type = "trait_display";

```


- [OnChainMetadata.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/OnChainMetadata.sol): This abstract contract provides the core functionalities for managing on-chain metadata.

```solidity

    // Get the first value of a token metadata key.
    function _getValue(uint256 tokenId, bytes32 key) internal view returns (bytes memory) { (...) }

    // Get the first value of a contract metadata key.
    function _getValue(bytes32 key) internal view returns (bytes memory) { (...) }

    // Set the values on a token metadata key.
    function _setValues(uint256 tokenId, bytes32 key, bytes[] memory values) internal { (...) }

    // Set a single value on a token metadata key.
    function _setValue(uint256 tokenId, bytes32 key, bytes memory value) internal { (...) }

    // Set values on a token metadata key.
    function _setValues(bytes32 key, bytes[] memory values) internal { (...) }

    // Set a single value on a token metadata key.
    function _setValue(bytes32 key, bytes memory value) internal { (...) }

    // Returns the token URI for the specified `tokenId` as a string.
    function _createTokenURI(uint256 tokenId) internal view virtual returns (string memory) { (...) }
    
    // Returns the contract URI as a string.
    function _createContractURI() internal view virtual returns (string memory) { (...) }

```


- [ERC721OnChainMetadata.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/ERC721OnChainMetadata.sol): This abstract contract extends ERC721 and OnChainMetadata. It provides the implementation of the tokenURI and contractURI functions required by NFT standards for metadata management.

- [ERC1155OnChainMetadata.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/ERC1155OnChainMetadata.sol): This abstract contract extends ERC1155 and OnChainMetadata. It provides the implementation of the uri and contractURI functions required by NFT standards for metadata management.


## Usage

The basic use is to inherit from [ERC721OnChainMetadata](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/ERC721OnChainMetadata.sol) or [ERC1155OnChainMetadata](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/ERC1155OnChainMetadata.sol), set contract metadata from constructor and set token metadata from mint function.

#### Examples

In the examples directory, you can find two usage examples of the protocol for creating ERC721 and ERC1155 contracts with on-chain metadata.

- [ERC721OnChainMetadataExample.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/examples/ERC721OnChainMetadataExample.sol): Example of ERC721 with on-chain SVG images. [See on Opensea](https://testnets.opensea.io/collection/erc721onchainmetadata-example).

- [ERC1155OnChainMetadataExample.sol](https://github.com/andreatedesco/OnChain-Protocol/blob/main/dapp/contracts/examples/ERC1155OnChainMetadataExample.sol): Example of ERC1155 with on-chain SVG images. [See on  Opensea](https://testnets.opensea.io/collection/erc1155onchainmetadata-example).


## Disclaimer

This software is provided as-is, and the developers make no warranties or representations, express or implied, about its functionality or suitability for any purpose. Use this software at your own risk. The developers shall not be liable for any direct, indirect, incidental, special, exemplary, or consequential damages arising out of the use or inability to use the software, even if advised of the possibility of such damages. Users are encouraged to thoroughly test and review the code before deploying it in any production environment. By using this software, you agree to these terms and assume full responsibility for any consequences that may arise from its use.


## Acknowledgments and Contributions

The entire protocol builds upon the work of the great [DanielAbalde](https://github.com/DanielAbalde/NFT-On-Chain-Metadata).
My work has been to streamline smart contracts, eliminate redundancies, and organize the overall structure in a more logical, extensible, and scalable way.

Don't hesitate to get involved by opening an Issue or submitting a Pull Request!

If you'd like to show your appreciation for the protocol, consider making a small contribution.
My wallet address is 0xecb4F374069a34CdDD096C697dD1e6fbD82D56b1.

Follow me on Twitter [@andreatedescoo](https://twitter.com/andreatedescoo) for updates and news!