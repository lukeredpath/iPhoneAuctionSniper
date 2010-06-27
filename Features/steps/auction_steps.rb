Given /^an auction is selling an item with the ID (\d+)$/ do |auction_id|
  @auction = FakeAuctionServer.new(auction_id)
end

Then /^the auction should have received a join request from the sniper$/ do
  @auction.assert_received_join_request_from_sniper
end

When /^the auction announces it has closed$/ do
  @auction.announce_closed
end
