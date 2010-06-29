# GIVENS
#------------------------------------------------------------------------------

Given /the application is running/ do 
  Given '"AuctionSniper.xcodeproj" is loaded in the iphone simulator'
  @application_runner = AuctionSniper::ApplicationRunner.new(simulator_driver)
end

Given /^the application has joined the auction$/ do
  @application_runner.join_auction(@auction)
  @auction.assert_received_join_request_from(Global.SNIPER_XMPP_ID)
end

Given /^the application is bidding on that item$/ do
  Given "the application has joined the auction"
  When "the auction reports a price of #{@default_price} + #{@default_bidder} from \"other bidder\""
  Then "the application should show the sniper is bidding"
  And "the auction should have received a bid of #{@default_price + @default_bidder} from the sniper"
end

# WHENS
#------------------------------------------------------------------------------

When /^the application joins the auction$/ do
  @application_runner.join_auction(@auction)
end

# THENS
#------------------------------------------------------------------------------

Then /^the application should show the sniper (is|has) (.*)$/ do |tense, state|
  @application_runner.send("assert_sniper_#{tense}_#{state}")
end

