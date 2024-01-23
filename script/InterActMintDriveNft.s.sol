// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import{Script} from "forge-std/Script.sol";

import{Drive} from "../src/Drive.sol";



contract InterActMintDriveNft is Script{


      function run() external {

        uint minter = vm.envUint("MINTERPRIVATEKEY");
        
        vm.startBroadcast(minter);
        Drive dirve =  Drive(0x8aa6670ab19499D92eCf12587c3935395d51489D);
        dirve.mint();
        vm.stopBroadcast();

    }
}