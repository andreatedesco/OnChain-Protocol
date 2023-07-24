// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../ERC1155OnChainMetadata.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev See on https://testnets.opensea.io/collection/erc1155onchainmetadata-example (https://mumbai.polygonscan.com/address/0x660Dc7436dCEc6762C566642B9141383bd6fC31a)
 */
contract ERC1155OnChainMetadataExample is ERC1155OnChainMetadata, Ownable {
    mapping(uint256 => bool) _ids;

    constructor() ERC1155("") {
        _setValue(
            OnChainMetadataStorage.key_contract_name,
            abi.encodePacked("ERC1155OnChainMetadata Example")
        );
        _setValue(
            OnChainMetadataStorage.key_contract_description,
            abi.encodePacked(
                "Simple example of ERC1155OnChainMetadata. See ",
                "https://github.com/andreatedesco/OnChain-Protocol",
                "."
            )
        );
        _setValue(
            OnChainMetadataStorage.key_contract_logo,
            createImage("Simple example of ERC1155OnChainMetadata")
        );
        _setValue(
            OnChainMetadataStorage.key_contract_banner,
            createImage("Simple example of ERC1155OnChainMetadata")
        );
        _setValue(
            OnChainMetadataStorage.key_contract_external_link,
            abi.encodePacked(
                "https://github.com/andreatedesco/OnChain-Protocol"
            )
        );

        mintWithMetadata(
            0,
            77,
            "Simple example of ERC1155OnChainMetadata",
            string(
                abi.encodePacked(
                    "Simple example of ERC1155OnChainMetadata. See ",
                    "https://github.com/andreatedesco/OnChain-Protocol",
                    "."
                )
            ),
            "https://github.com/andreatedesco/OnChain-Protocol"
        );
    }

    function mintWithMetadata(
        uint256 id,
        uint256 amount,
        string memory name,
        string memory description,
        string memory url
    ) public onlyOwner {
        _setValue(
            id,
            OnChainMetadataStorage.key_token_name,
            abi.encodePacked(name)
        );
        _setValue(
            id,
            OnChainMetadataStorage.key_token_description,
            abi.encodePacked(description)
        );
        _setValue(
            id,
            OnChainMetadataStorage.key_token_image,
            createImage(name)
        );
        _setValue(
            id,
            OnChainMetadataStorage.key_token_animation_url,
            abi.encodePacked(url)
        );
        _mint(msg.sender, id, amount, "");
    }

    function createImage(
        string memory text
    ) public pure returns (bytes memory) {
        return
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="512" height="512"><rect width="510" height="510" fill="white" stroke="black"/><text x="50" y="250">',
                        text,
                        "</text></svg>"
                    )
                )
            );
    }
}
