// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import{Script} from "forge-std/Script.sol";

import{Drive} from "../src/Drive.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployDrive is Script{

    function run() external {
        uint deprivate = vm.envUint("PRIVATEKEY");

        string memory classicImageSvg = vm.readFile("./image_svgs/Classic.svg");

        string memory SportsImageSvg = vm.readFile("./image_svgs/Sports.svg");

        vm.startBroadcast(deprivate);

        Drive drive = new Drive(svgToImgUri(classicImageSvg),svgToImgUri(SportsImageSvg));

        vm.stopBroadcast();
    }

    function svgToImgUri(string memory svgimg) internal pure returns(string memory){

        string memory baseURI = "data:image/svg+xml;base64,";

        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svgimg))) 
        );

        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }

}