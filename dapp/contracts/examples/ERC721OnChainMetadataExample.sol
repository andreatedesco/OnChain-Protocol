// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../ERC721OnChainMetadata.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @author Andrea Tedesco (@andreatedesco).
 * @dev See on https://testnets.opensea.io/collection/erc721onchainmetadata-example (https://mumbai.polygonscan.com/address/0x72e546aaECE917a2D7b5A54604dFc1bC698929da)
 */
contract ERC721OnChainMetadataExample is ERC721OnChainMetadata, Ownable {
    bytes32 constant key_token_title = "title";
    bytes32 constant key_token_card_color = "cardColor";
    bytes32 constant key_token_border_color = "borderColor";
    bytes32 constant key_token_text_color = "textColor";

    uint256 private _tokenCount;

    constructor() ERC721("ERC721OnChainMetadataExample", "OC721") {
        _setValue(
            OnChainMetadataStorage.key_contract_name,
            abi.encodePacked("ERC721OnChainMetadata Example")
        );
        _setValue(
            OnChainMetadataStorage.key_contract_description,
            abi.encodePacked(
                "Simple example of ERC721OnChainMetadata. See ",
                "https://github.com/andreatedesco/OnChain-Protocol",
                "."
            )
        );
        _setValue(
            OnChainMetadataStorage.key_contract_logo,
            createImage(
                "ERC721OnChainMetadata Contract",
                "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAADW0lEQVRIDbVWTUwTQRT+ZnaXUjUaglK8KBrx52CM3rybYIitEDAxeJODMd7hIpAWG0BPejN6M54IGDT8nSQmJh6M4aA2BmMUTWixKCSApe3O+Gbb3XZ3216ML9ndeT/z/t9rGYZeSPxH4LV082hXLTZYLAw+3FFTRq/KjYaRmr6HpksRyMHnPjFOylOzI2CMYX9bGOAMGPDLVTSwO96FL7Oj0JiJ1FwMzRc7LQMSEgyc3gZS8wNgAvQUMsykovuBVaqBEYtg+e5xgC7pksFE0HXT5EpVFoHT1yz6DtsHU+douXATwhOtrwba/StYetCOgCAFMgMNf1CHX64nKH4jYG5g68OkZSAgNxDMbUJIfww+A+ZGHnu3P7o8roRwpmNPPo3sj3fEpvxXAZ+BKnIVyUpt/dpb1G0noWWSCFWw4zNgUKk29GZkKa/rdaGKir3E/NIU8GkCidEj1LoRF9vVRVq0A8l4K/j1GTQ0NEAnj1bpkgKBHNV8F4QQ1JEMmsy7FNkIpy4zbYS+ngiIZayTNpOyqiHPNUdUCKL0vkGo/zMO9C1ZMg6z7JAeOQRELzsUVwSSGTBlEOaj80iNHkWAvLa9MfQceZOzBooJDdS9FUtr0ZmamAI4c8DinUjHD6Kx/7tj3SAVqbEWC1cXdJMMlIGp4ienvJBl9WjuS4BmDE4ENLQQZ26Q7G1HfmXssHOW5FX+7C0HVwdJMbHFx2DcXQ9rDouSjgGFc6lbu6XIo+saGBVTkGJGZZa+QaJdca4XcvGhky6NVsd04qutohSBRSEvV+eHEWq7g5W5KEy2UxTMgAt/KhTTJDeUx2pHKZhLLNO75HfpZLEpCtNAcmYITW39RUrhQ52Jn7Q9vfBqsxXi/TdKF0VjAy+pdU5i8Bka28NIz4yozGKNtqgb3NtSFf315jFynVKnHrewgzkGFIUJpbrQYmol1waGPO2jnKZmhsIrM6FBpbaQssK7qEmFubB1orZeW5Z0qpnl4z0ueSojep4Qc4jWB4HLgOrb7u5uvMyccl3yIirOha2TpF6D0LLELiXIO4DOoLmUxDowOTFBXVS6WM7npEWoX7CpiPVVm8qGq0/r6adz3EbJlSr/Krxb0blRPBSyrnaVvUwUg1YINUs5VDVQLvQv57+5KR/Iu9t7wgAAAABJRU5ErkJggg==",
                "white",
                "black",
                "black"
            )
        );
        _setValue(
            OnChainMetadataStorage.key_contract_external_link,
            abi.encodePacked(
                "https://github.com/andreatedesco/OnChain-Protocol"
            )
        );

        mintToken(
            "Doge",
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAADW0lEQVRIDbVWTUwTQRT+ZnaXUjUaglK8KBrx52CM3rybYIitEDAxeJODMd7hIpAWG0BPejN6M54IGDT8nSQmJh6M4aA2BmMUTWixKCSApe3O+Gbb3XZ3216ML9ndeT/z/t9rGYZeSPxH4LV082hXLTZYLAw+3FFTRq/KjYaRmr6HpksRyMHnPjFOylOzI2CMYX9bGOAMGPDLVTSwO96FL7Oj0JiJ1FwMzRc7LQMSEgyc3gZS8wNgAvQUMsykovuBVaqBEYtg+e5xgC7pksFE0HXT5EpVFoHT1yz6DtsHU+douXATwhOtrwba/StYetCOgCAFMgMNf1CHX64nKH4jYG5g68OkZSAgNxDMbUJIfww+A+ZGHnu3P7o8roRwpmNPPo3sj3fEpvxXAZ+BKnIVyUpt/dpb1G0noWWSCFWw4zNgUKk29GZkKa/rdaGKir3E/NIU8GkCidEj1LoRF9vVRVq0A8l4K/j1GTQ0NEAnj1bpkgKBHNV8F4QQ1JEMmsy7FNkIpy4zbYS+ngiIZayTNpOyqiHPNUdUCKL0vkGo/zMO9C1ZMg6z7JAeOQRELzsUVwSSGTBlEOaj80iNHkWAvLa9MfQceZOzBooJDdS9FUtr0ZmamAI4c8DinUjHD6Kx/7tj3SAVqbEWC1cXdJMMlIGp4ienvJBl9WjuS4BmDE4ENLQQZ26Q7G1HfmXssHOW5FX+7C0HVwdJMbHFx2DcXQ9rDouSjgGFc6lbu6XIo+saGBVTkGJGZZa+QaJdca4XcvGhky6NVsd04qutohSBRSEvV+eHEWq7g5W5KEy2UxTMgAt/KhTTJDeUx2pHKZhLLNO75HfpZLEpCtNAcmYITW39RUrhQ52Jn7Q9vfBqsxXi/TdKF0VjAy+pdU5i8Bka28NIz4yozGKNtqgb3NtSFf315jFynVKnHrewgzkGFIUJpbrQYmol1waGPO2jnKZmhsIrM6FBpbaQssK7qEmFubB1orZeW5Z0qpnl4z0ueSojep4Qc4jWB4HLgOrb7u5uvMyccl3yIirOha2TpF6D0LLELiXIO4DOoLmUxDowOTFBXVS6WM7npEWoX7CpiPVVm8qGq0/r6adz3EbJlSr/Krxb0blRPBSyrnaVvUwUg1YINUs5VDVQLvQv57+5KR/Iu9t7wgAAAABJRU5ErkJggg==",
            "black",
            "white",
            "white"
        );
        mintToken(
            "Mars",
            "data:image/png;base64,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",
            "red",
            "green",
            "blue"
        );
        mintToken(
            "Pepe",
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAABF0lEQVRIDWO8ffv2fwYaAiYamg02euhbwIIviCa/tMEqnSt+hAGfHLImRmyRjEszTOOLiwwMEvowHiYNcgAM0DwOMHxAyPUwl4F8AQKEfAKPg8e/TjNseF8I0QUlJ1q/QOGDOIyMjAz///9nCL8oAZZDVwOTB0neuXOHgeZBBLYAFCzorge5IP+oBBiD2MgA5EoYCJ8G8QmMD6JB8jA1NPcBOJKJjVhkVxLDBiVXeCSjayhexI0uRDL/VykD7SMZpw9AzpWfdY9kVyNruA30AU4LNjr+YJj9QBxZPVlsnBbckf3LUKxAWTz8AjoJXlRgy8lkORmoia6FHTyjybKZothMDdeDzIAHEbkGEtIH9wEhheTK09wCAK4kV2GvPXC/AAAAAElFTkSuQmCC",
            "pink",
            "aqua",
            "yellow"
        );
    }

    function mintToken(
        string memory title,
        string memory image,
        string memory cardColor,
        string memory borderColor,
        string memory textColor
    ) public onlyOwner {
        uint256 tokenId = _tokenCount;

        _setValue(
            tokenId,
            OnChainMetadataStorage.key_token_name,
            abi.encodePacked("Token #", Strings.toString(tokenId), " - ", title)
        );
        _setValue(
            tokenId,
            OnChainMetadataStorage.key_token_description,
            _getValue(OnChainMetadataStorage.key_contract_description)
        );
        _setValue(
            tokenId,
            OnChainMetadataStorage.key_token_image,
            createImage(title, image, cardColor, borderColor, textColor)
        );
        _setValue(
            tokenId,
            OnChainMetadataStorage.key_token_external_url,
            _getValue(OnChainMetadataStorage.key_contract_external_link)
        );

        _setValue(tokenId, key_token_title, abi.encodePacked(title));
        _setValue(tokenId, key_token_card_color, abi.encodePacked(cardColor));
        _setValue(
            tokenId,
            key_token_border_color,
            abi.encodePacked(borderColor)
        );
        _setValue(tokenId, key_token_text_color, abi.encodePacked(textColor));

        bytes[] memory trait_types = new bytes[](4);
        bytes[] memory trait_values = new bytes[](4);
        bytes[] memory trait_display = new bytes[](4);
        trait_types[0] = abi.encodePacked("title");
        trait_types[1] = abi.encodePacked("cardColor");
        trait_types[2] = abi.encodePacked("borderColor");
        trait_types[3] = abi.encodePacked("textColor");
        trait_values[0] = abi.encodePacked(title);
        trait_values[1] = abi.encodePacked(cardColor);
        trait_values[2] = abi.encodePacked(borderColor);
        trait_values[3] = abi.encodePacked(textColor);
        trait_display[0] = abi.encodePacked("");
        trait_display[1] = abi.encodePacked("");
        trait_display[2] = abi.encodePacked("");
        trait_display[3] = abi.encodePacked("");
        _setValues(
            tokenId,
            OnChainMetadataStorage.key_token_attributes_trait_type,
            trait_types
        );
        _setValues(
            tokenId,
            OnChainMetadataStorage.key_token_attributes_trait_value,
            trait_values
        );
        _setValues(
            tokenId,
            OnChainMetadataStorage.key_token_attributes_display_type,
            trait_display
        );

        _tokenCount = _tokenCount + 1;
        _safeMint(msg.sender, tokenId, "");
    }

    function createImage(
        string memory title,
        string memory image,
        string memory cardColor,
        string memory borderColor,
        string memory textColor
    ) internal pure returns (bytes memory) {
        return
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '<?xml version="1.0" encoding="iso-8859-1"?><svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve"><style>.t00 {font: bold 24px bahnschrift;text-anchor: middle;fill:',
                        textColor,
                        '}</style><rect width="510" height="510" x="50%" y="50%" transform="translate(-255,-255)" style="fill:',
                        cardColor,
                        ";stroke-width:2;stroke:",
                        borderColor,
                        '"/><text x="256" y="55" class="t00">',
                        title,
                        '</text><rect width="390" height="390" x="50%" y="50%" transform="translate(-195,-190)" style="fill:',
                        cardColor,
                        ";stroke-width:1;stroke:",
                        borderColor,
                        '"/><image width="390" height="390" x="50%" y="50%" transform="translate(-195,-190)" style="image-rendering:pixelated;" href="',
                        image,
                        '"/></svg>'
                    )
                )
            );
    }
}
