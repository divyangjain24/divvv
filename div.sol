// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTTradingPost {
    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool active;
    }

    mapping(uint256 => Listing) public listings;
    uint256 public listingCounter;

    function createListing(address nftContract, uint256 tokenId, uint256 price) external {
        listings[listingCounter] = Listing(msg.sender, nftContract, tokenId, price, true);
        listingCounter++;
    }

    function buyNFT(uint256 listingId) external payable {
        Listing storage listing = listings[listingId];
        require(listing.active, "Listing is not active");
        require(msg.value >= listing.price, "Insufficient payment");
        
        listing.active = false;
        payable(listing.seller).transfer(msg.value);
    }
}
