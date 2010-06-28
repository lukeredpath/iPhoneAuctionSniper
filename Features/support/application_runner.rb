module AuctionSniper
  unless const_defined?('STATUS_JOINING')
    STATUS_JOINING = "Joining"
    STATUS_BIDDING = "Bidding"
    STATUS_LOST    = "Lost"
  end
  
  module Assertions
    include Test::Unit::Assertions
    
    def assert_sniper_has_joined_auction
      assert @auction_driver.shows_sniper_status?(STATUS_BIDDING)
    end
    
    def assert_sniper_has_lost_auction
      assert @auction_driver.shows_sniper_status?(STATUS_LOST)
    end
  end
  
  module Actions
    def join_auction(auction)
      assert @auction_driver.shows_sniper_status?(STATUS_JOINING)
    end
  end
  
  class ApplicationRunner
    include Assertions
    include Actions
    
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
      @auction_driver = AuctionDriver.new(simulator_driver)
    end
  end
end
