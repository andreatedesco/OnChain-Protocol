// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev This library provides functions for creating token and contract URIs formatted according to the official NFT metadata standards.
 */
library OnChainMetadataBuilder {
    /**
     * @dev Internal function to create the token URI.
     *
     * @param name The name of the token.
     * @param description The description of the token.
     * @param image The image of the token.
     * @param external_url The external URL of the token.
     * @param trait_type The trait types associated with the token.
     * @param trait_value The trait values associated with the token.
     * @param trait_display The trait display types associated with the token.
     * @param animation_url The animation URL of the token.
     * @param youtube_url The YouTube URL of the token.
     * @param background_color The background color of the token.
     * @return The token URI as a string.
     */
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
    ) external pure returns (string memory) {
        bytes memory attributes;
        if (trait_type.length > 0) {
            attributes = "[";
            for (uint256 i = 0; i < trait_type.length; i++) {
                attributes = abi.encodePacked(
                    attributes,
                    i > 0 ? "," : "",
                    "{",
                    trait_display[i].length > 0
                        ? string(
                            abi.encodePacked(
                                '"display_type": "',
                                string(trait_display[i]),
                                '",'
                            )
                        )
                        : "",
                    '"trait_type": "',
                    string(trait_type[i]),
                    '", "value": "',
                    string(trait_value[i]),
                    '"}'
                );
            }
            attributes = abi.encodePacked(attributes, "]");
        }

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        abi.encodePacked(
                            "{",
                            '"name": "',
                            name,
                            '", ',
                            '"description": "',
                            description,
                            '"',
                            image.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "image": "',
                                        string(image),
                                        '"'
                                    )
                                )
                                : "",
                            animation_url.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "animation_url": "',
                                        string(animation_url),
                                        '"'
                                    )
                                )
                                : "",
                            external_url.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "external_url": "',
                                        string(external_url),
                                        '"'
                                    )
                                )
                                : "",
                            attributes.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "attributes": ',
                                        attributes
                                    )
                                )
                                : "",
                            background_color.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "background_color": ',
                                        string((background_color))
                                    )
                                )
                                : "",
                            youtube_url.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "youtube_url": ',
                                        string((youtube_url))
                                    )
                                )
                                : "",
                            "}"
                        )
                    )
                )
            );
    }

    /**
     * @dev Internal function to create the contract URI.
     *
     * @param name The name of the contract.
     * @param description The description of the contract.
     * @param image The image of the contract.
     * @param banner The banner of the contract.
     * @param external_url The external URL of the contract.
     * @return The contract URI as a string.
     */
    function createContractURI(
        bytes memory name,
        bytes memory description,
        bytes memory image,
        bytes memory banner,
        bytes memory external_url
    ) external pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        abi.encodePacked(
                            "{",
                            '"name": "',
                            string(name),
                            '"',
                            description.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "description": "',
                                        string(description),
                                        '"'
                                    )
                                )
                                : "",
                            image.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "image": "',
                                        string(image),
                                        '"'
                                    )
                                )
                                : "",
                            banner.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "banner": "',
                                        string(banner),
                                        '"'
                                    )
                                )
                                : "",
                            external_url.length > 0
                                ? string(
                                    abi.encodePacked(
                                        ', "external_link": "',
                                        string(external_url),
                                        '"'
                                    )
                                )
                                : "",
                            "}"
                        )
                    )
                )
            );
    }
}
