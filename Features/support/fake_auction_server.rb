require 'xmp44r-simple'

module AuctionSniper
  module Assertions
    def assert_received_join_request_from_sniper
      
    end
  end
  
  module Actions
    def announce_closed
      
    end
  end
  
  class FakeAuctionServer
    include Assertions
    include Actions
    
    attr_reader :auction_id
    
    def initialize(auction_id)
      @auction_id = auction_id
    end
  end
end
