// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

//  import the helper functions from the contract 
import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter public _tokenIdd;

    string svgPartOne = "<svg version='1.2' baseProfile='tiny-ps' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 500 500' width='500' height='500'>";
    string svgPartTwo= "</svg>";

    string[] background = [
        "<style>tspan { white-space:pre }.s0 { fill: #efff00 } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>",
        "<style>tspan { white-space:pre }.s0 { fill: #00c5ff } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>",
        "<style>tspan { white-space:pre }.s0 { fill: #ff7900 } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>",
        "<style>tspan { white-space:pre }.s0 { fill: #9100ff } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>",
        "<style>tspan { white-space:pre }.s0 { fill: #0005ff } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>"
    ];
    string[] head_1 = [
        "<style>tspan { white-space:pre }.s18 { fill: #00ffdf } </style><g ><path class='s18' d='m250 380c-71.89 0-130-58.11-130-130c0-71.89 58.11-130 130-130c71.89 0 130 58.11 130 130c0 71.89-58.11 130-130 130z' /></g>",
        "<style>tspan { white-space:pre }.s18 { fill: #0083ff } </style><g ><path class='s18' d='m250 380c-71.89 0-130-58.11-130-130c0-71.89 58.11-130 130-130c71.89 0 130 58.11 130 130c0 71.89-58.11 130-130 130z' /></g>",
        "<style>tspan { white-space:pre }.s18 { fill: #ff6d00 } </style><g ><path class='s18' d='m250 380c-71.89 0-130-58.11-130-130c0-71.89 58.11-130 130-130c71.89 0 130 58.11 130 130c0 71.89-58.11 130-130 130z' /></g>"
    ];
    string[] head_2 = [ 
        "<style>tspan { white-space:pre }.s19 { fill: #9100ff } </style><g ><path class='s19' d='m249.5 357c-59.45 0-107.5-48.05-107.5-107.5c0-59.45 48.05-107.5 107.5-107.5c59.45 0 107.5 48.05 107.5 107.5c0 59.45-48.05 107.5-107.5 107.5z' /></g>", 
        "<style>tspan { white-space:pre }.s19 { fill: #adff00 } </style><g ><path class='s19' d='m249.5 357c-59.45 0-107.5-48.05-107.5-107.5c0-59.45 48.05-107.5 107.5-107.5c59.45 0 107.5 48.05 107.5 107.5c0 59.45-48.05 107.5-107.5 107.5z' /></g>", 
        "<style>tspan { white-space:pre }.s19 { fill: #ff0089 } </style><g ><path class='s19' d='m249.5 357c-59.45 0-107.5-48.05-107.5-107.5c0-59.45 48.05-107.5 107.5-107.5c59.45 0 107.5 48.05 107.5 107.5c0 59.45-48.05 107.5-107.5 107.5z' /></g>"
    ];
    string[] petal_1_1 = [
        "<style>tspan { white-space:pre }.s32 { fill: #00ff19 } </style><g ><g ><path class='s32' d='m250.5 174c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>", 
        "<style>tspan { white-space:pre }.s32 { fill: #ff0035 } </style><g ><g ><path class='s32' d='m250.5 174c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>", 
        "<style>tspan { white-space:pre }.s32 { fill: #ff00ff } </style><g ><g ><path class='s32' d='m250.5 174c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
    ];
    string[] petal_1_2 = [
        "<style>tspan { white-space:pre }.s33 { fill: #ff9700 } </style><g ><g ><path class='s33' d='m250 148c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s33 { fill: #efff00 } </style><g ><g ><path class='s33' d='m250 148c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s33 { fill: #0100ff } </style><g ><g ><path class='s33' d='m250 148c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_2_1 = [
        "<style>tspan { white-space:pre }.s35 { fill: #ff00ff } </style><g ><g ><path class='s35' d='m353.5 205c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s35 { fill: #00ff19 } </style><g ><g ><path class='s35' d='m353.5 205c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s35 { fill: #ff0035 } </style><g ><g ><path class='s35' d='m353.5 205c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
    ];
    string[] petal_2_2 = [
        "<style>tspan { white-space:pre }.s34 { fill: #ff9700 } </style><g ><g ><path class='s34' d='m348 183c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s34 { fill: #9100ff } </style><g ><g ><path class='s34' d='m348 183c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s34 { fill: #0100ff } </style><g ><g ><path class='s34' d='m348 183c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_3_1 = [
        "<style>tspan { white-space:pre }.s6 { fill: #ff00ff } </style><g ><g ><path class='s6' d='m390.5 312c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s6 { fill: #00ff19 } </style><g ><g ><path class='s6' d='m390.5 312c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s6 { fill: #ff0035 } </style><g ><g ><path class='s6' d='m390.5 312c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
    ];
    string[] petal_3_2 = [
        "<style>tspan { white-space:pre }.s7 { fill: #ff9700 } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s7 { fill: #efff00 } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s7 { fill: #0100ff } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_4_1 = [
        "<style>tspan { white-space:pre }.s8 { fill: #ff00ff } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s8 { fill: #00ff19 } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s8 { fill: #ff0035 } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"

    ];
    string[] petal_4_2 = [
        "<style>tspan { white-space:pre }.s9 { fill: #ff9700 } </style><g ><g ><path class='s9' d='m340 381c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s9 { fill: #9100ff } </style><g ><g ><path class='s9' d='m340 381c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s9 { fill: #00c5ff } </style><g ><g ><path class='s9' d='m340 381c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_5_1 = [
        "<style>tspan { white-space:pre }.s10 { fill: #ff00ff } </style><g ><g ><path class='s10' d='m250.5 457c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s10 { fill: #00ff19 } </style><g ><g ><path class='s10' d='m250.5 457c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s10 { fill: #ff0035 } </style><g ><g ><path class='s10' d='m250.5 457c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"

    ];
    string[] petal_5_2 = [
        "<style>tspan { white-space:pre }.s11 { fill: #ff9700 } </style><g ><g ><path class='s11' d='m250 416c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s11 { fill: #1900ff } </style><g ><g ><path class='s11' d='m250 416c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s11 { fill: #0100ff } </style><g ><g ><path class='s11' d='m250 416c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_6_1 = [
        "<style>tspan { white-space:pre }.s12 { fill: #ff00ff } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s12 { fill: #00ff19 } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s12 { fill: #ff0035 } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"

    ];
    string[] petal_6_2 = [
        "<style>tspan { white-space:pre }.s13 { fill: #ff9700 } </style><g ><g ><path class='s13' d='m151 375c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s13 { fill: #1900ff } </style><g ><g ><path class='s13' d='m151 375c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s13 { fill: #00c5ff } </style><g ><g ><path class='s13' d='m151 375c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_7_1 = [
        "<style>tspan { white-space:pre }.s14 { fill: #ff0035 } </style><g ><g ><path class='s14' d='m111.5 313c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s14 { fill: #ff00ff } </style><g ><g ><path class='s14' d='m111.5 313c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s14 { fill: #00ff19 } </style><g ><g ><path class='s14' d='m111.5 313c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"

    ];
    string[] petal_7_2 = [
        "<style>tspan { white-space:pre }.s15 { fill: #1900ff } </style><g ><g ><path class='s15' d='m116 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s15 { fill: #00c5ff } </style><g ><g ><path class='s15' d='m116 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s15 { fill: #ff9700 } </style><g ><g ><path class='s15' d='m116 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];
    string[] petal_8_1 = [
        "<style>tspan { white-space:pre }.s16 { fill: #ff0035 } </style><g ><g ><path class='s16' d='m147.5 212c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s16 { fill: #00ff19 } </style><g ><g ><path class='s16' d='m147.5 212c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
        "<style>tspan { white-space:pre }.s16 { fill: #ff00ff } </style><g ><g ><path class='s16' d='m147.5 212c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
    ];
    string[] petal_8_2 = [
        "<style>tspan { white-space:pre }.s17 { fill: #ff9700 } </style><g ><g ><path class='s17' d='m151 186c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s17 { fill: #1900ff } </style><g ><g ><path class='s17' d='m151 186c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
        "<style>tspan { white-space:pre }.s17 { fill: #efff00 } </style><g ><g ><path class='s17' d='m151 186c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
    ];

    event newEpicNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("FlowersOnChain", "FOC") {
        console.log("Cute Little Flowers, 100% stored and generated on chain!");
    }

    // Randomize attributes

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function totalMintedSoFar() public view returns (uint256) {
        return _tokenIds.current();
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();
        require(
            newItemId < 50,
            "50 NFTs have already been minted try again later"
        );

        uint256 rand = random(Strings.toString(newItemId));
        rand = rand % background.length;
        string memory b = background[rand];

        string memory combinedSvg1 = string(
            abi.encodePacked(b, 
                            petal_1_1[rand], 
                            petal_1_2[rand],
                            petal_2_1[rand],
                            petal_2_2[rand]
                            )
        );

        string memory combinedSvg2 = string(
            abi.encodePacked(petal_3_1[rand], 
                            petal_3_2[rand],
                            petal_4_1[rand],
                            petal_4_2[rand]
                            )
        );

        string memory combinedSvg3 = string(
            abi.encodePacked(petal_5_1[rand], 
                            petal_5_2[rand],
                            petal_6_1[rand],
                            petal_6_2[rand]
                            )
        );

        string memory combinedSvg4 = string(
            abi.encodePacked(petal_7_1[rand], 
                            petal_7_2[rand],
                            petal_8_1[rand],
                            petal_8_2[rand]
                            )
        );
        
        string memory combinedSvg5 = string(
            abi.encodePacked(head_1[rand], 
                            head_2[rand]
                            )
        );

        string memory finalSvg = string(
            abi.encodePacked(
                svgPartOne,
                combinedSvg1,
                combinedSvg2,
                combinedSvg3,
                combinedSvg4,
                combinedSvg5,
                svgPartTwo
            )
        );

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // set the title of our NFT as the generated word.
                        "Test Flower",
                        '", "description": "Cute little flowers, 100% stored and generated on chain!", "image": "data:image/svg+xml;base64,',
                        //add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        // We'll be setting the tokenURI later!
        _setTokenURI(newItemId, finalTokenUri);
        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        emit newEpicNFTMinted(msg.sender, newItemId);
    }
}
