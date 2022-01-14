// SPDX-License-Identifier: UNLICENSED
// FlowersOnChain NFT
pragma solidity ^0.8.0;
 
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
    	"<style>tspan { white-space:pre }.s0 { fill: #ff7900 } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>",
    	"<style>tspan { white-space:pre }.s0 { fill: #0005ff } </style><g ><path class='s0' d='m0 0h500v500h-500v-500z' /></g>"
	];
	string stem = "<style>tspan { white-space:pre }.s55 { fill: #009a0f } </style><g ><path class='s55' d='m236 449h27v157h-27v-157z' /></g>";
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
    	"<style>tspan { white-space:pre }.s6 { fill: #ff0035 } </style><g ><g ><path class='s6' d='m390.5 312c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
    	"<style>tspan { white-space:pre }.s6 { fill: #00ff19 } </style><g ><g ><path class='s6' d='m390.5 312c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
	];
	string[] petal_3_2 = [
    	"<style>tspan { white-space:pre }.s7 { fill: #ff9700 } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
    	"<style>tspan { white-space:pre }.s7 { fill: #efff00 } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>",
    	"<style>tspan { white-space:pre }.s7 { fill: #0100ff } </style><g ><g ><path class='s7' d='m386 280c-16.59 0-30-13.41-30-30c0-16.59 13.41-30 30-30c16.59 0 30 13.41 30 30c0 16.59-13.41 30-30 30z' /></g></g>"
	];
	string[] petal_4_1 = [
    	"<style>tspan { white-space:pre }.s8 { fill: #00ff19 } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
    	"<style>tspan { white-space:pre }.s8 { fill: #ff0035 } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
    	"<style>tspan { white-space:pre }.s8 { fill: #ff00ff } </style><g ><g ><path class='s8' d='m346.5 418c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
 
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
    	"<style>tspan { white-space:pre }.s12 { fill: #ff0035 } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
    	"<style>tspan { white-space:pre }.s12 { fill: #ff00ff } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>",
    	"<style>tspan { white-space:pre }.s12 { fill: #00ff19 } </style><g ><g ><path class='s12' d='m139.5 416c-34.56 0-62.5-27.94-62.5-62.5c0-34.56 27.94-62.5 62.5-62.5c34.56 0 62.5 27.94 62.5 62.5c0 34.56-27.94 62.5-62.5 62.5z' /></g></g>"
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
	string[] extra = [
    	"<style>tspan { white-space:pre }.s37 { fill: #ff0089 } </style><g ><path class='s37' d='m250 279c-16.04 0-29-12.96-29-29c0-16.04 12.96-29 29-29c16.04 0 29 12.96 29 29c0 16.04-12.96 29-29 29z' /></g>",
    	"<style>tspan { white-space:pre }.s37 { fill: #ff0089 } </style><g ><path class='s37' d='m250 279c-16.04 0-29-12.96-29-29c0-16.04 12.96-29 29-29c16.04 0 29 12.96 29 29c0 16.04-12.96 29-29 29z' /></g>",
    	"<style>tspan { white-space:pre }.s37 { fill: #ff0089 } </style><g ><path class='s37' d='m250 279c-16.04 0-29-12.96-29-29c0-16.04 12.96-29 29-29c16.04 0 29 12.96 29 29c0 16.04-12.96 29-29 29z' /></g>",
    	"<style>tspan { white-space:pre }.s37 { fill: #000000 } .s67 { fill: #00ff13 } </style><g ><g ><path class='s37' d='m160 57h180v17h-180v-17z' /><path class='s37' d='m204 20h91v54h-91v-54z' /><path class='s67' d='m204 36h91v10h-91v-10z' /></g></g>",
    	"<style>tspan { white-space:pre }.s37 { fill: #8a8a8a } .s68 { fill: #29ff00 } </style><g ><path class='s37' d='m92.99 297.16l14.85-14.85l14.85 14.85l-14.85 14.85l-14.85-14.85z' /><path class='s68' d='m108 301c-2.21 0-4-1.79-4-4c0-2.21 1.79-4 4-4c2.21 0 4 1.79 4 4c0 2.21-1.79 4-4 4z' /></g>"
 
	];
	string eye_1_1 = "<style>tspan { white-space:pre }.s22 { fill: #ffffff } </style><g ><g ><path class='s22' d='m297 279c-17.14 0-31-13.86-31-31c0-17.14 13.86-31 31-31c17.14 0 31 13.86 31 31c0 17.14-13.86 31-31 31z' /></g></g>";
	string eye_1_2 = "<style>tspan { white-space:pre }.s23 { fill: #ffffff } </style><g ><g ><path class='s23' d='m204 279c-17.14 0-31-13.86-31-31c0-17.14 13.86-31 31-31c17.14 0 31 13.86 31 31c0 17.14-13.86 31-31 31z' /></g></g>";
	string eye_2_1 = "<style>tspan { white-space:pre }.s24 { fill: #000000 } </style><g ><g ><path class='s24' d='m198 256c-4.42 0-8-3.58-8-8c0-4.42 3.58-8 8-8c4.42 0 8 3.58 8 8c0 4.42-3.58 8-8 8z' /></g></g>";
	string eye_2_2 = "<style>tspan { white-space:pre }.s25 { fill: #000000 } </style><g ><g ><path class='s25' d='m302 256c-4.42 0-8-3.58-8-8c0-4.42 3.58-8 8-8c4.42 0 8 3.58 8 8c0 4.42-3.58 8-8 8z' /></g></g>";
	string[] eye_3 = [
    	"<style>tspan { white-space:pre }.s26 { fill: #9b73ff } </style><g ><g ><path class='s26' d='m200 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /><path class='s26' d='m300 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /></g></g>",
    	"<style>tspan { white-space:pre }.s26 { fill: #00ff19 } </style><g ><g ><path class='s26' d='m200 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /><path class='s26' d='m300 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /></g></g>",
    	"<style>tspan { white-space:pre }.s26 { fill: #ff9700 } </style><g ><g ><path class='s26' d='m200 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /><path class='s26' d='m300 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /></g></g>",
    	"<style>tspan { white-space:pre }.s26 { fill: #efff00  } </style><g ><g ><path class='s26' d='m200 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /><path class='s26' d='m300 268c-11.06 0-20-8.94-20-20c0-11.06 8.94-20 20-20c11.06 0 20 8.94 20 20c0 11.06-8.94 20-20 20z' /></g></g>"
	];
	string[] mouth = [
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m225.99 299.53l48.1-0.06' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000 } </style><g ><g ><path class='s21' d='m249.5 314c-17.42 0-31.5-4.47-31.5-10c0-5.53 14.08-10 31.5-10c17.42 0 31.5 4.47 31.5 10c0 5.53-14.08 10-31.5 10z' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m239 297.06l24-0.06' /><path class='s21' d='m256 290l0.06 26.5' /><path class='s21' d='m239 309.06l24-0.06' /><path class='s21' d='m246.06 316l-0.06-26' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m225.99 299.53l48.1-0.06' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m225.99 301.53l48.1-0.06' /><path class='s21' d='m266.07 310l-0.06-16' /><path class='s21' d='m233.07 310l-0.06-16' /><path class='s21' d='m255.07 310l-0.06-16' /><path class='s21' d='m244.07 310l-0.06-16' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m225.99 299.53l48.1-0.06' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m199 299.53l105-0.06' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m225.99 299.53l48.1-0.06' /></g></g>",
		"<style>tspan { white-space:pre }.s21 { fill: #ffffff } .s91 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m235.5 306c-2.49 0-4.5-2.01-4.5-4.5c0-2.49 2.01-4.5 4.5-4.5c2.49 0 4.5 2.01 4.5 4.5c0 2.49-2.01 4.5-4.5 4.5z' /><path class='s21' d='m264.5 306c-2.49 0-4.5-2.01-4.5-4.5c0-2.49 2.01-4.5 4.5-4.5c2.49 0 4.5 2.01 4.5 4.5c0 2.49-2.01 4.5-4.5 4.5z' /><path class='s91' d='m225.99 299.53l48.1-0.06' /></g></g>"
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m262 313.96l-13.86-14.08' /><path class='s21' d='m285 313.96l-13.86-14.08' /><path class='s21' d='m215.14 313.96l13.86-14.08' /><path class='s21' d='m260.14 313.96l13.86-14.08' /><path class='s21' d='m237.14 313.96l13.86-14.08' /><path class='s21' d='m240 313.96l-13.86-14.08' /></g></g>",
    	"<style>tspan { white-space:pre }.s21 { fill: #000000;stroke: #000000;stroke-width: 5 } </style><g ><g ><path class='s21' d='m231 312.97l38.01-22.34' /><path class='s21' d='m231 312.34l38.01-22.34' /><path class='s21' d='m231 314.21l38.01-22.34' /><path class='s21' d='m269.01 314.21l-38.01-22.34' /><path class='s21' d='m269.01 312.97l-38.01-22.34' /><path class='s21' d='m269.01 314.84l-38.01-22.34' /></g></g>"
	];
 
	event newEpicNFTMinted(address sender, uint256 tokenId);
 
	constructor() ERC721("FlowersOnChain", "FOC") {
    	console.log("Cute Little Flowers, 100% stored and generated on chain!");
	}
 
	// Randomize attributes
	uint256[] public numberArr = [0,1,1,2,2,0,1,2,0,2,2,2,1,0,0,1,0,1,2];
	uint256[] public numberArr_ = [0,1,2,3,4,5,6,7,8,9];
	uint256[] public numberArr__ = [0,1,2];
	uint256[] public numberArr___ = [0,1,2,3];
	function random(uint256 input, uint256[] memory arr) internal returns (uint256) {
		for (uint256 i = 0; i < arr.length; i++) {
			uint256 n = uint256(keccak256(abi.encodePacked(block.difficulty))) % arr.length;
			uint256 temp = numberArr[n];
			numberArr[n] = numberArr[i];
			numberArr[i] = temp;
		}
    	return uint256(keccak256(abi.encodePacked(block.difficulty))) % input;
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

    	uint256 rand_ = random(background.length, numberArr___);
    	string memory b = background[rand_];
		uint256 rand__ = random(head_1.length, numberArr);
		console.log(rand__, b);
    	string memory combinedSvg1 = string(
        	abi.encodePacked(background[numberArr[18]],
                        	stem,
                        	petal_1_1[numberArr[0]],
                        	petal_1_2[numberArr[1]],
                        	petal_2_1[numberArr[2]],
                        	petal_2_2[numberArr[3]]
                        	)
    	);
    	string memory combinedSvg2 = string(
        	abi.encodePacked(petal_3_1[numberArr[4]],
                        	petal_3_2[numberArr[5]],
                        	petal_4_1[numberArr[6]],
                        	petal_4_2[numberArr[7]]
                        	)
    	);
    	string memory combinedSvg3 = string(
        	abi.encodePacked(petal_5_1[numberArr[8]],
                        	petal_5_2[numberArr[9]],
                        	petal_6_1[numberArr[10]],
                        	petal_6_2[numberArr[11]]
                        	)
    	);
    	string memory combinedSvg4 = string(
        	abi.encodePacked(petal_7_1[numberArr[12]],
                        	petal_7_2[numberArr[13]],
                        	petal_8_1[numberArr[14]],
                        	petal_8_2[numberArr[15]],
							extra[rand_]
                        	)
    	);
    	// uint256 new_rand = rand % extra.length;
    	// uint256 new_rand_ = rand % mouth.length;
    	uint256 new_rand = newItemId % eye_3.length;
    	uint256 new_rand_ = newItemId % mouth.length;
    	string memory combinedSvg5 = string(
        	abi.encodePacked(head_1[numberArr[16]],
                        	head_2[numberArr[17]],
                        	eye_1_1,
                        	eye_1_2,
                        	eye_3[new_rand],
                        	eye_2_1,
                        	eye_2_2,
                        	mouth[new_rand_]
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
						// set the attributes "attributes": [{"trait_type": "Background","value": "1"},{"trait_type": "Fur","value": "10"},{"trait_type": "Earring","value": "0"},{"trait_type": "Hat","value": "0"},{"trait_type": "Eyes","value": "0"},{"trait_type": "Clothes","value": "33"},{"trait_type": "Mouth","value": "0"}],
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
