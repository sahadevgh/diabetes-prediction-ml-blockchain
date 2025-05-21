// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MLTraceability {
    
    struct LogEvent {
        string eventType;      // e.g., "preprocessing", "training", "prediction"
        string hashValue;      // SHA-256 hash of the file or artifact
        string modelVersion;   // e.g., "v1.0"
        string timestamp;      // ISO 8601 string
        string description;    // Optional notes
        address user;          // Ethereum address that logged it
    }

    // Mapping eventId => LogEvent
    mapping(string => LogEvent) private eventLogs;
    string[] private eventIds;

    // Authorized loggers (simple role-based access control)
    mapping(address => bool) private authorizedUsers;
    address public owner;

    constructor() {
        owner = msg.sender;
        authorizedUsers[owner] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedUsers[msg.sender], "Not an authorized user.");
        _;
    }

    // Add an authorized user
    function addAuthorizedUser(address _user) public onlyOwner {
        authorizedUsers[_user] = true;
    }

    // Remove an authorized user
    function removeAuthorizedUser(address _user) public onlyOwner {
        authorizedUsers[_user] = false;
    }

    // Log an event to the blockchain
    function logEvent(
        string memory eventId,
        string memory eventType,
        string memory hashValue,
        string memory modelVersion,
        string memory timestamp,
        string memory description
    ) public onlyAuthorized {
        require(bytes(eventLogs[eventId].hashValue).length == 0, "Event already exists");

        eventLogs[eventId] = LogEvent({
            eventType: eventType,
            hashValue: hashValue,
            modelVersion: modelVersion,
            timestamp: timestamp,
            description: description,
            user: msg.sender
        });

        eventIds.push(eventId);
    }

    // Retrieve a specific event
    function getEvent(string memory eventId) public view returns (
        string memory eventType,
        string memory hashValue,
        string memory modelVersion,
        string memory timestamp,
        string memory description,
        address user
    ) {
        LogEvent memory log = eventLogs[eventId];
        return (
            log.eventType,
            log.hashValue,
            log.modelVersion,
            log.timestamp,
            log.description,
            log.user
        );
    }

    // Retrieve all logged event IDs
    function getAllEventIds() public view returns (string[] memory) {
        return eventIds;
    }
}
