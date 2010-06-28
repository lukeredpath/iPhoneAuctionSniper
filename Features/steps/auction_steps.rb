TEST_AUCTION_ID = '1'

Given /^an auction is selling an item$/ do
  @auction = AuctionSniper::FakeAuctionServer.new(TEST_AUCTION_ID)
  @auction.start_selling_item
end

Then /^the auction should have received a join request from the sniper$/ do
  @auction.assert_received_join_request_from(Global.SNIPER_XMPP_ID)
end

When /^the auction announces it has closed$/ do
  @auction.announce_closed
end

When /^the auction reports a price of (\d+) \+ (\d+) from "([^\"]*)"$/ do |price, increment, bidder|
  @auction.report_price(price, increment, bidder)
end

Then /^the auction should have received a bid of (\d+) from the sniper$/ do |amount|
  @auction.assert_received_bid(amount, Global.SNIPER_XMPP_ID)
end

After do
  @auction.stop if @auction
end
