Given /^an auction is selling an item named (.*)$/ do |item_id|
  Auction.create(item_id)
end

Given /^an auction is selling items (.*)$/ do |item_ids|
  item_ids.split(", ").each { |item_id| Auction.create(item_id) }
end

Then /^the auction for (.*) should have received a join request from the sniper$/ do |item_id|
  Auction.for(item_id).assert_received_join_request_from(Global.SNIPER_XMPP_ID)
end

When /^the auction for (.*) announces it has closed$/ do |item_id|
  Auction.for(item_id).announce_closed
end

When /^the auction for (.*) reports a price of (\d+) \+ (\d+) from "([^\"]*)"$/ do |item_id, price, increment, bidder|
  Auction.for(item_id).report_price(price, increment, bidder)
end

When /^the auction for (.*) reports a price of (\d+) \+ (\d+) from the sniper$/ do |item_id, price, increment|
  Auction.for(item_id).report_price(price, increment, Global.SNIPER_XMPP_ID)
end

Then /^the auction for (.*) should have received a bid of (\d+) from the sniper$/ do |item_id, amount|
  Auction.for(item_id).assert_received_bid(amount, Global.SNIPER_XMPP_ID)
end

After do
  Auction.each { |auction| auction.stop }
end
