TEST_AUCTION_ID = '1'

Given /^an auction is selling an item$/ do
  @auction = AuctionSniper::FakeAuctionServer.new(TEST_AUCTION_ID)
  @auction.start_selling_item
end

Then /^the auction should have received a join request from the sniper$/ do
  @auction.assert_received_join_request_from_sniper
end

When /^the auction announces it has closed$/ do
  @auction.announce_closed
end
