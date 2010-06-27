module AuctionSniper
  class AuctionDriver
    def initialize(simulator)
      @simulator = simulator
    end
    
    def shows_sniper_status?(status_string)
      @simulator.screen.exists?(status_string, '//UILabel')
    end
  end
end
