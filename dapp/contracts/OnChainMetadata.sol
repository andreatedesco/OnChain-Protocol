// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./OnChainMetadataStorage.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev The developer is responsible for assigning metadata for the contract
 * and tokens, by inheriting this contract and using _addValue() and _setValue() methods.
 */
abstract contract OnChainMetadata {
    using OnChainMetadataStorage for OnChainMetadataStorage.Metadata;

    // metadata for the contract
    OnChainMetadataStorage.Metadata private _contractMetadata;

    // metadata for each token
    mapping(uint256 => OnChainMetadataStorage.Metadata) private _tokenMetadata;

    /**
     * @dev Get the first value of a token metadata key.
     * @param tokenId the token identifier.
     * @param key the token metadata key.
     */
    function _getValue(
        uint256 tokenId,
        bytes32 key
    ) internal view returns (bytes memory) {
        return _tokenMetadata[tokenId].getValue(key);
    }

    /**
     * @dev Get the first value of a contract metadata key.
     * @param key the contract metadata key.
     */
    function _getValue(bytes32 key) internal view returns (bytes memory) {
        return _contractMetadata.getValue(key);
    }

    /**
     * @dev Set the values on a token metadata key.
     * @param tokenId the token identifier.
     * @param key the token metadata key.
     * @param values the token metadata values.
     */
    function _setValues(
        uint256 tokenId,
        bytes32 key,
        bytes[] memory values
    ) internal {
        _tokenMetadata[tokenId].data[key] = values;
    }

    /**
     * @dev Set a single value on a token metadata key.
     * @param tokenId the token identifier.
     * @param key the token metadata key.
     * @param value the token metadata value.
     */
    function _setValue(
        uint256 tokenId,
        bytes32 key,
        bytes memory value
    ) internal {
        bytes[] memory values = new bytes[](1);
        values[0] = value;
        _setValues(tokenId, key, values);
    }

    /**
     * @dev Set values on a token metadata key.
     * @param key the token metadata key.
     * @param values the token metadata values.
     */
    function _setValues(bytes32 key, bytes[] memory values) internal {
        _contractMetadata.data[key] = values;
    }

    /**
     * @dev Set a single value on a token metadata key.
     * @param key the token metadata key.
     * @param value the token metadata value.
     */
    function _setValue(bytes32 key, bytes memory value) internal {
        bytes[] memory values = new bytes[](1);
        values[0] = value;
        _setValues(key, values);
    }

    /**
     * @dev Returns the token URI for the specified `tokenId` as a string.
     */
    function _createTokenURI(
        uint256 tokenId
    ) internal view virtual returns (string memory) {
        return _tokenMetadata[tokenId].createTokenURI();
    }

    /**
     * @dev Returns the contract URI as a string.
     */
    function _createContractURI()
        internal
        view
        virtual
        returns (string memory)
    {
        return _contractMetadata.createContractURI();
    }
}
