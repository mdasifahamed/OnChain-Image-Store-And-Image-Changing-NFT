// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Test,console} from "forge-std/Test.sol";
import {Drive} from "../src/Drive.sol";
import{Base64} from  "@openzeppelin/contracts/utils/Base64.sol";




contract DriveTest is Test,Script {

    Drive drive;

    address public user = makeAddr("minter");

    function setUp() external {
        vm.deal(user,10 ether);
        vm.prank(user);
        string memory classicImageSvg = vm.readFile("./image_svgs/Classic.svg");
        string memory SportsImageSvg = vm.readFile("./image_svgs/Sports.svg");
        drive = new Drive(svgToImgUri(classicImageSvg),svgToImgUri(SportsImageSvg));

    }

    function svgToImgUri(string memory svgimg) internal pure returns(string memory){

        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svgimg))) 
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }


    function testTokenUri() public view {
        string memory uri = drive.tokenURI(0);
        console.log(uri);
    }
    function testChangeCar() public  {
        
        drive.changeCar(0);
        string memory uri = drive.tokenURI(0);
        console.log(uri);
    }

    function testName() public {
        string memory name = "DRIVE";
        assertEq(keccak256(abi.encodePacked(name)),keccak256(abi.encodePacked(drive.name())));
    }

}