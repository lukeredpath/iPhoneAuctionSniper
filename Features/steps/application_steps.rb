# GIVENS
#------------------------------------------------------------------------------

Given /the application is running/ do 
  Given '"AuctionSniper.xcodeproj" is loaded in the iphone simulator'
  @application_runner = AuctionSniper::ApplicationRunner.new(simulator_driver)
end

Given /^the application has joined the auction$/ do
  @application_runner.join_auction(@auction)
end

# WHENS
#------------------------------------------------------------------------------

When /^the application joins the auction$/ do
  @application_runner.join_auction(@auction)
end

# THENS
#------------------------------------------------------------------------------

Then /^the application should show the sniper has joined the auction$/ do
  @application_runner.assert_sniper_has_joined_auction
end

Then /^the application should show the sniper has lost the auction$/ do
  @application_runner.assert_sniper_has_lost_auction
end
