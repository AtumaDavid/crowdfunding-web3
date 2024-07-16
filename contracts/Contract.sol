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
    // campaigns stores all the Campaign

    // Variable to keep track of the total number of campaigns created
    uint256 public numberOfCampaigns = 0;

    // Function to create a new campaign
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image ) public returns(uint256){
        Campaign storage campaign = campaigns[numberOfCampaigns];

        // Ensure the campaign deadline is in the future
        // require: This is a Solidity function used to check if a condition is true. If the condition is false, the transaction is reverted, and an optional error message is provided.
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future"); //explain this, and what is block.timestamp

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
    function donateToCampaign(uint256 _id) public payable {
        // msg is a global variable in Solidity that holds details about the transaction that called the contract
        // msg.value is the amount of Ether sent with the transaction
        uint256 amount = msg.value;  // Store the amount of Ether sent with the transaction in the variable 'amount'

        // Retrieve the campaign from the storage using the provided campaign ID
        // This line fetches the Campaign struct from the campaigns mapping using the provided _id and assigns it to the campaign variable.
        Campaign storage campaign = campaigns[_id]; 

        // after determining the campaign to which the donation is being made, these lines update the campaign's records to reflect the new donation.
        // Add the sender's address to the list of donators for this campaign
        campaign.donators.push(msg.sender); //msg.sender is a global variable in Solidity that contains the address of the account that called the function (i.e., the account making the donation).
        // Add the donation amount to the list of donations for this campaign
        campaign.donations.push(amount); //This line records the donation amount to keep track of the total funds contributed by various donors.

        // Attempt to send the donation amount to the campaign owner
        // bool sent: Declares a boolean variable sent that will capture the success or failure of the transfer.
        // payable: This is a type cast that converts the address campaign.owner into a payable address. Only payable addresses can receive Ether.
        (bool sent, ) = payable(campaign.owner).call{value: amount}(""); 
        // The line attempts to send the donation amount (amount) of Ether to the campaign owner's address (campaign.owner). 
        // It uses the low-level .call method, which is flexible and can handle complex scenarios but must be used carefully due to its ability to forward all gas and its handling of failure. 
        // The success of the call is captured in the boolean variable sent, while the second return value (a data byte array) is ignored.

        // If the transfer was successful, update the amount collected for the campaign
        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }


    // Function to retrieve the list of addresses who have donated to a specific campaign
    function getDonators(uint256 _id ) view public returns(address[] memory, uint256[] memory){
        return(campaigns[_id].donators, campaigns[_id].donations);
    }

    // Function to retrieve details of all campaigns created
    function getCampaigns() public  view returns (Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for(uint i = 0; i < numberOfCampaigns; i++){
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
}