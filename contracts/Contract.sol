// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {
    struct Campaign{
        address owner;           // Address of the campaign owner
        string title;            // Title of the campaign
        string description;      // Description of the campaign
        uint256 target;          // Target amount of funds to be raised
        uint256 deadline;        // Deadline by which the target amount needs to be raised
        uint256 amountCollected; // Amount of funds collected so far
        string image;            // URL or hash of the campaign image
        address[] donators;      // Array of addresses who have donated to the campaign
        uint256[] donations;     // Array of donation amounts corresponding to each donator
    }

    // Mapping to store campaign structs by their unique identifiers
    mapping(uint256 => Campaign) public campaigns;

    // Variable to keep track of the total number of campaigns created
    uint256 public numberOfCampaigns = 0;

    // Function to create a new campaign
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image ) public returns(uint256){
        Campaign storage campaign = campaigns[numberOfCampaigns];

        //Ensure the campaign deadline is in the future
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future");

        // Initialize campaign details
        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;

    }

    // Function to allow users to donate to a campaign
    function donateToCampaign(uint256 _id) public payable{}

    // Function to retrieve the list of addresses who have donated to a specific campaign
    function getDonators(){}

    // Function to retrieve details of all campaigns created
    function getCampaigns(){}
}