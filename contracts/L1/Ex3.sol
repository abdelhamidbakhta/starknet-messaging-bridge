// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IStarknetCore {

    function sendMessageToL2(
        uint256 to_address,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);

    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);

    function l2ToL1Messages(bytes32 msgHash) external view returns (uint256);
}

interface ISolution {
    function consumeMessage(uint256 l2ContractAddress, uint256 l2User) external;
}


contract Ex3 is ISolution{
    IStarknetCore starknetCore;
    address constant public STARKNET_CORE = 0xde29d060D45901Fb19ED6C6e959EB22d8626708e;

    constructor() {
        starknetCore = IStarknetCore(STARKNET_CORE);
    }

    function consumeMessage(uint256 l2ContractAddress, uint256 l2User) override external {
        uint256[] memory payload = new uint256[](1);
        payload[0] = l2User;
        starknetCore.consumeMessageFromL2(
            l2ContractAddress,
            payload
        );
    }
}