// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract WillRegistry {
    struct Will {
        address owner;
        string content;
        uint256 version;
        uint256 timestamp;
    }

    mapping (address => Will[]) public wills;

    event NewWill(address indexed owner, uint256 version);
    event UpdatedWill(address indexed owner, uint256 version);

    function createWill(string memory _content) public {
        Will memory newWill = Will(msg.sender, _content, 1, block.timestamp);
        wills[msg.sender].push(newWill);
        emit NewWill(msg.sender, 1);
    }

    function updateWill(string memory _content) public {
        Will storage currentWill = wills[msg.sender][wills[msg.sender].length - 1];
        currentWill.version++;
        currentWill.content = _content;
        currentWill.timestamp = block.timestamp;
        emit UpdatedWill(msg.sender, currentWill.version);
    }

    function getWill(address _owner) public view returns (Will[] memory) {
        return wills[_owner];
    }
}
