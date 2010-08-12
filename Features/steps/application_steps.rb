# GIVENS
#------------------------------------------------------------------------------

Given /the application is running/ do 
  Given '"AuctionSniper.xcodeproj" is loaded in the iphone simulator'
  @application_runner = AuctionSniper::ApplicationRunner.new(simulator_driver)
end

Given /^the application has started bidding for (.*)$/ do |item_id|
  @application_runner.start_bidding_in(Auction.for(item_id))
  Then "the auction for #{item_id} should have received a join request from the sniper"
end

When /^the application starts bidding for (.*)$/ do |item_ids|
  auctions = item_ids.split(", ").map { |item_id| Auction.for(item_id) }
  @application_runner.start_bidding_in(*auctions)
end

# WHENS
#------------------------------------------------------------------------------

When /^the application joins the auction for (.*)$/ do |item_id|
  @application_runner.join_auction(Auction.for(item_id))
end

# THENS
#------------------------------------------------------------------------------

Then /^the application should show the sniper is winning with a bid of (\d+) for (.*)$/ do |winning_bid, item_id|
  @application_runner.assert_sniper_is_winning_with_bid(winning_bid, Auction.for(item_id))
end

Then /^the application should show the sniper is bidding (\d+) for (.*)$/ do |bid_amount, item_id|
  @application_runner.assert_sniper_is_bidding(bid_amount, Auction.for(item_id))
end

Then /^the application should show the sniper has won with a bid of (\d+) for (.*)$/ do |winning_bid, item_id|
  @application_runner.assert_sniper_has_won_with_bid(winning_bid, Auction.for(item_id))
end

Then /^the application should show the sniper (is|has) (.*) the auction for (.*)$/ do |tense, state, item_id|
  @application_runner.send("assert_sniper_#{tense}_#{state}", Auction.for(item_id))
end
