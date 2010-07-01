module AuctionSniper
  STATUS_JOINING = "Joining"
  STATUS_BIDDING = "Bidding"
  STATUS_LOST    = "Lost"
  STATUS_WINNING = "Winning"
  STATUS_WON     = "Won"
  
  ASSERTION_TIMEOUT = 1
  
  module Assertions
    include Test::Unit::Assertions
    
    def assert_sniper_is_bidding(auction)
      try_assertion_for(ASSERTION_TIMEOUT) do
        next_bid = next_bid_for(auction)
        @auction_driver.assert_shows_sniper_status(auction.auction_id, auction.current_price, next_bid, STATUS_BIDDING)
        self.current_bid = next_bid
      end
    end
    
    def assert_sniper_is_winning(auction)
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(auction.auction_id, self.current_bid, self.current_bid, STATUS_WINNING)
      end
    end
    
    def assert_sniper_has_won(auction)
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(auction.auction_id, self.current_bid, self.current_bid, STATUS_WON)
      end
    end
    
    def assert_sniper_has_lost(auction)
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(auction.auction_id, nil, nil, STATUS_LOST)
      end
    end
  end
  
  module Actions
    def join_auction(auction)
      @auction_driver.assert_shows_sniper_status(auction.auction_id, nil, nil, STATUS_JOINING)
    end
  end
  
  class ApplicationRunner
    include Assertions
    include Actions
    
    attr_accessor :current_bid
    
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
      @auction_driver = AuctionDriver.new(simulator_driver)
    end
    
    def next_bid_for(auction)
      auction.current_price + auction.current_increment
    end
    
    def try_assertion_for(number_of_seconds, &block)
      assertion_error = nil
      SystemTimer.timeout(number_of_seconds) do
        begin
          yield
        rescue Test::Unit::AssertionFailedError => e
          assertion_error = e
          sleep(0.1)
          retry
        end
      end
    rescue Timeout::Error
      raise assertion_error
    end
  end
end
