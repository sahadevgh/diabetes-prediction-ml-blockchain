// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MLTraceability {
    struct DataRecord {
        string dataHash; // SHA-256 hash of data/model
        string metadata; // JSON string with timestamp, model version, etc.
        address submitter; // Address of the submitter
        uint256 timestamp; // Submission timestamp
    }

    DataRecord[] public records;
    mapping(string => bool) public hashExists;

    event HashSubmitted(string dataHash, string metadata, address submitter, uint256 timestamp);
    event HashVerified(string dataHash, bool exists);

    // Submit a hash and metadata (Section 3.5)
    function submitHash(string memory dataHash, string memory metadata) public {
        require(!hashExists[dataHash], "Hash already exists");
        hashExists[dataHash] = true;
        records.push(DataRecord(dataHash, metadata, msg.sender, block.timestamp));
        emit HashSubmitted(dataHash, metadata, msg.sender, block.timestamp);
    }

    // Verify if a hash exists (Section 3.5)
    function verifyHash(string memory dataHash) public returns (bool) {
        bool exists = hashExists[dataHash];
        emit HashVerified(dataHash, exists);
        return exists;
    }

    // Get all logged records for auditing (Section 3.5)
    function getHistory() public view returns (DataRecord[] memory) {
        return records;
    }
}