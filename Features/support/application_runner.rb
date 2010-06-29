module AuctionSniper
  STATUS_JOINING = "Joining"
  STATUS_BIDDING = "Bidding"
  STATUS_LOST    = "Lost"
  STATUS_WINNING = "Winning"
  STATUS_WON     = "Won"
  
  ASSERTION_TIMEOUT = 1
  
  module Assertions
    include Test::Unit::Assertions
    
    def assert_sniper_is_bidding
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(STATUS_BIDDING)
      end
    end
    
    def assert_sniper_is_winning
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(STATUS_WINNING)
      end
    end
    
    def assert_sniper_has_won
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(STATUS_WON)
      end
    end
    
    def assert_sniper_has_lost
      try_assertion_for(ASSERTION_TIMEOUT) do
        @auction_driver.assert_shows_sniper_status(STATUS_LOST)
      end
    end
  end
  
  module Actions
    def join_auction(auction)
      @auction_driver.assert_shows_sniper_status(STATUS_JOINING)
    end
  end
  
  class ApplicationRunner
    include Assertions
    include Actions
    
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
      @auction_driver = AuctionDriver.new(simulator_driver)
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
