// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./OnChainMetadataBuilder.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev The library offers functions for retrieving and creating on-chain metadata for contracts and tokens.
 * With OnChainMetadataStorage, contract and token metadata can be securely stored and accessed directly on the blockchain,
 * eliminating the need for off-chain storage solutions and ensuring data integrity and immutability.
 */
library OnChainMetadataStorage {
    struct Metadata {
        mapping(bytes32 => bytes[]) data; // key => values
    }

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

    /**
     * @dev Retrieves the values associated with the specified key.
     *
     * @param metadata The metadata storage.
     * @param key The key to retrieve the values for.
     * @return An array of values associated with the key.
     */
    function getValues(
        Metadata storage metadata,
        bytes32 key
    ) public view returns (bytes[] memory) {
        return metadata.data[key];
    }

    /**
     * @dev Retrieves the value associated with the specified key.
     *
     * @param metadata The metadata storage.
     * @param key The key to retrieve the value for.
     * @return The value associated with the key.
     */
    function getValue(
        Metadata storage metadata,
        bytes32 key
    ) public view returns (bytes memory) {
        bytes[] memory array = getValues(metadata, key);
        if (array.length > 0) {
            return array[0];
        } else {
            return "";
        }
    }

    /**
     * @dev Creates the token URI based on the metadata.
     *
     * @param metadata The metadata storage.
     * @return The token URI as a string.
     */
    function createTokenURI(
        Metadata storage metadata
    ) external view returns (string memory) {
        return
            OnChainMetadataBuilder.createTokenURI(
                getValue(metadata, key_token_name),
                getValue(metadata, key_token_description),
                getValue(metadata, key_token_image),
                getValue(metadata, key_token_external_url),
                getValues(metadata, key_token_attributes_trait_type),
                getValues(metadata, key_token_attributes_trait_value),
                getValues(metadata, key_token_attributes_display_type),
                getValue(metadata, key_token_animation_url),
                getValue(metadata, key_token_youtube_url),
                getValue(metadata, key_token_background_color)
            );
    }

    /**
     * @dev Creates the contract URI based on the metadata.
     *
     * @param metadata The metadata storage.
     * @return The contract URI as a string.
     */
    function createContractURI(
        Metadata storage metadata
    ) external view returns (string memory) {
        return
            OnChainMetadataBuilder.createContractURI(
                getValue(metadata, key_contract_name),
                getValue(metadata, key_contract_description),
                getValue(metadata, key_contract_logo),
                getValue(metadata, key_contract_banner),
                getValue(metadata, key_contract_external_link)
            );
    }
}
